import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Text(
        "Json Placeholder",
        style: GoogleFonts.openSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xff141515),
          letterSpacing: 0.04,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
      ),
      // child: Image.asset(
      //   "assets/images/logo.png",
      //   height: 33,
      //   width: 158,
      // ),
    );
  }
}
