import 'package:brainburst/constants/api.dart';
import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/screens/learning_page.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ProfilePage extends StatelessWidget {
  // final String? username;
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<String> username = getUser();
    // fetchData();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      // width : double.infinity,
      // height : double.infinity,
      decoration: ShapeDecoration(
        color: Clr.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Center(
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
              color: Clr.darkPurple, 
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   //     scrollDirection: Axis.horizontal,
                  //   children: [
                  //     Image.asset('assets/badges/badge1.png'),
                  //     Image.asset('assets/badges/badge2.png'),
                  //     Image.asset('assets/badges/badge3.png'),
                  //     // Image.asset('assets/badges/badge4.png'),
                  //   ],
                  // ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: _generatePieSections(watched),
                        borderData: FlBorderData(show: false),
                        startDegreeOffset: -90,
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 90),
              width: 392,
              height: 78,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  Api().logout();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
      ),
    );
  }
}

Future<void> fetchData() async {
  final response =
      await http.get(Uri.parse('http://192.168.29.218:8000/welcome'));

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

List<PieChartSectionData> _generatePieSections(List<bool> watchedStatus) {
  int watchedCount = watchedStatus.where((status) => status).length;
  int unwatchedCount = watchedStatus.length - watchedCount;

  List<PieChartSectionData> sections = [];

  sections.add(PieChartSectionData(
    color: Clr.mossGreen, // Color for watched
    value: watchedCount.toDouble(),
    title: 'Watched',
    radius: 15,
    titleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xffffffff),
    ),
  ));

  sections.add(PieChartSectionData(
    color: const Color.fromARGB(80, 137, 157, 120), // Color for unwatched
    value: unwatchedCount.toDouble(),
    title: 'Unwatched', 
    radius: 15,
    titleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xffffffff),
    ),
  ));

  return sections;
}
