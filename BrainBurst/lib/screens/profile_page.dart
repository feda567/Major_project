import 'package:brainburst/constants/api.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  // final String? username;
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<String> username = getUser();
    // fetchData();
    return Container(
      
      width: 393,
      height: 852,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            // width: 297,
            height: 100,
            child: Text(
              'PROFILE',
              style: GoogleFonts.inknutAntiqua(
                color: Colors.black,
                fontSize: 42,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          const Icon(
            Icons.person,
            size: 150,
          ),
          Text(
            // Api.token,
            "Username: ${Api.user}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: 392,
            height: 264,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.85, -0.53),
                end: Alignment(-0.85, 0.53),
                colors: [Color(0xFFFA99C8), Color(0x00FA99C8)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Badges Earned',
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('assets/badges/badge1.png'),
                    Image.asset('assets/badges/badge2.png'),
                    Image.asset('assets/badges/badge3.png'),
                    // Image.asset('assets/badges/badge4.png'),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 90),
            width: 392,
            height: 78,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(1.00, -0.01),
                end: Alignment(-1, 0.01),
                colors: [Color(0xFFFA99C8), Color(0x00FA99C8)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Api().logout();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),  
                    child: Image.asset('assets/sign_out.png'),
                  ),
                  Text(
                    'Sign out',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://192.168.29.218:8000/welcome'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // then parse the JSON.
    List<dynamic> data = jsonDecode(response.body);
    print(data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
