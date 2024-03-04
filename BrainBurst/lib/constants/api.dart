class Api {
  static const String baseUrl = 'http://192.168.68.89:8000/';  
  static var token = "";         
  static List<Map<String, dynamic>> chapters = []; 
  tokenchange(String newtoken) {
    token = newtoken;
  }   
  static String user= "";
  static bool logedIn = false;
  login(String newuser) {
    user = newuser;
    logedIn = true;
    print("logged in");
  }
  logout() {
    user = "";
    token = "";
    logedIn = false;
    print("logged out");
  }
  // getChapters(List<Map<String, dynamic>> chapters) {
  //   this.chapters = chapters;
  // }

}


// import 'package:http/http.dart' as http;

// class Api {
//   static const String baseUrl = 'http://192.168.1.81:8000/';
//   static var token = "";

//   tokenchange(String newtoken) {
//     token = newtoken;
//   }

  
// }

