import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';

class GamingPage extends StatelessWidget {
  const GamingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 852,
      width: 393,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.39, 0.92),
          end: Alignment(-0.39, -0.92),
          colors: [Color(0xFFF7D5E5), Color(0x00FA99C8)],
        ),
      ),
      child: Column(
        children: [
          const ScanningPageLogo(),
          ScanningIndexTile(
            fontsizewid: 24,
            icon: Container(
              width: 50,
              height: 55,
              decoration: const ShapeDecoration(
                color: Color(0xFFF399DA),
                shape: OvalBorder(),
              ),
              child: Image.asset('assets/gaming_page/gaming_tile1.png'),
            ), 
            text: 'TIC TAC TOE',
          ),
          ScanningIndexTile(
            fontsizewid: 19,
            icon: Container(
              width: 50,
              height: 55,
              decoration: const ShapeDecoration(
                color: Color(0xFFF399DA),
                shape: OvalBorder(),
              ),
              child: Image.asset('assets/gaming_page/gaming_tile2.png'),
            ),
            text: 'GUESS THE NUMBER',
          ),
        ],
      ),
    );
  }
}
