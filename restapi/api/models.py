from django.db import models


# Create your models here.
class VideosDb(models.Model):
    title = models.CharField(max_length=100)
    link = models.URLField(max_length=100)
    id = models.AutoField(primary_key=True)
