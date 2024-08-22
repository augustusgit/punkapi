
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punkapi/screens/home_screen.dart';

import '../../utils/colors.dart';
import '../../utils/next_screen.dart';
import '../../widgets/display_app_bar.dart';

class EmptyProduct extends StatefulWidget {
  EmptyProduct();

  @override
  _EmptyProductState createState() => _EmptyProductState();
}

class _EmptyProductState extends State<EmptyProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: displayMobileAppBar(context, isImage: true, showAction: true, showBack: false, scaffoldKey: _scaffoldKey),
      body: Column(children: [
        SizedBox(height: _height * .02),
        Row(
          children: [
            SizedBox(width: _width * 0.07),
            Text(
              "No Content",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.02,
                color: appColorPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: _height * .18),
        Image.asset(
          "assets/images/noty.png",
          height: _height * 0.3,
        ),
        SizedBox(
          height: _height * .01,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: _width * .03),
          child: Text(
            "Post not available",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff98A4B5)),
          ),
        ),
        SizedBox(height: _height * .185),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .05),
          child: Row(children: [
            Center(
              child: InkWell(
                onTap: () {
                  nextScreenReplace(context, HomeScreen());
                },
                child: Container(
                  height: _height * .0633,
                  width: _width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: appColorPrimary,
                  ),
                  child: Center(
                    child: Text(
                      "Retry",
                      style: GoogleFonts.poppins(
                        color: appWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.68,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
