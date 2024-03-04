import 'package:brainburst/models/branch.dart';
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlphabetsPage extends StatelessWidget {
  const AlphabetsPage({super.key});

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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 520,
            width: 340,
            child: GridView.count(
              crossAxisCount: 3,
              children: const [
                AlphabetBox('അ'),
                AlphabetBox('ആ'),
                AlphabetBox('ഇ'),
                AlphabetBox('ഈ'),
                AlphabetBox('ഉ'),
                AlphabetBox('ഊ'),
                AlphabetBox('ഋ'),
                AlphabetBox('എ'),
                AlphabetBox('ഏ'),
                AlphabetBox('ഐ'),
                AlphabetBox('ഒ'),
                AlphabetBox('ഓ'),
                AlphabetBox('ഔ'),
                AlphabetBox('അം'),
                AlphabetBox('അഃ'),
                AlphabetBox('ക'),
                AlphabetBox('ഖ'),
                AlphabetBox('ഗ'),
                AlphabetBox('ഘ'),
                AlphabetBox('ങ'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AlphabetBox extends StatelessWidget {
  final String data;
  const AlphabetBox(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
        final branchProvider = context.watch<BranchProvider>();

    return InkWell(
      onTap: () {
        branchProvider.changeBranchIndex(3); 
      },
      child: Container(
        width: 94,
        height: 84,
        margin: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: const Color(0xFFEBE8B1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 5,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.black.withOpacity(0.20000000298023224),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
            child: Text(
          data,
          style: GoogleFonts.markoOne(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        )),
      ),
    );
  }
}
