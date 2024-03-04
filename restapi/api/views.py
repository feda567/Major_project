from django.http import HttpResponse, JsonResponse

from .models import VideosDb
from .serializers import UserLogin, UserRegister, VideoSerializer
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from django.contrib.auth import login as autologin, authenticate, get_user
from django.core import serializers


from rest_framework.permissions import IsAuthenticated


class Register(APIView):

    @staticmethod
    def post(request):
        serializer = UserRegister(data=request.data)
        data = {}
        if serializer.is_valid():
            account = serializer.save()
            data['response'] = 'registered'
            data['username'] = account.username
            data['email'] = account.email
            token = Token.objects.get_or_create(user=account).key
            data['token'] = token
        else:
            data = serializer.errors
        return Response(data)


class Login(APIView):

    @staticmethod
    def post(request):
        serializer = UserLogin(data=request.data)
        data = {}
        print("request")
        if serializer.is_valid():
            username = serializer.validated_data['username']
            password = serializer.validated_data['password']
            print(username)
            user = authenticate(username=username, password=password)
            print(user)
            if user is not None:
                # print(user)
                autologin(request, user)
                data['response'] = 'logged in'
                data['username'] = user.username
                data['email'] = user.email
                token = Token.objects.get(user=user).key
                data['token'] = token
                # return render(request, 'index.html', data)
                print(data)
            else:
                data['response'] = 'invalid credentials'
        else:
            data = serializer.errors
        return Response(data)


class Welcome(APIView):
    permission_classes = (IsAuthenticated,)

    @staticmethod
    def get(request):
        content = {'user': str(request.user), 'userid': str(request.user.id)}
        return Response(content)


class Videos(APIView):
    @staticmethod
    def get(self):
        data = VideoSerializer(VideosDb.objects.all(), many=True).data
        return JsonResponse(data, safe=False)
