import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/Post.dart';
import '../utils/colors.dart';
import '../widgets/display_app_bar.dart';

class PostDetails extends StatefulWidget {
  final Post postItem;

  PostDetails(this.postItem);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: displayMobileAppBar(context, isImage: true, showAction: true, showBack: false, scaffoldKey: _scaffoldKey),
        body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                        //height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * .432,
                        child: Image.network(
                                widget.postItem.url!,
                                fit: BoxFit.fill,
                              )
                            ),
                    _bottomBar(context),
                  ],
                ),
              )

      );
  }

  Widget _bottomBar(context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: appWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(children: [
        // isLoading ? LoadingIndicatorWidget() : Container(),
        SizedBox(
          height: _height * 0.040,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _width * 0.75,
                child: Text(
                  widget.postItem.title!,
                  style: GoogleFonts.openSans(
                    fontSize: _height * .024,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff141515),
                    letterSpacing: 0.04,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height * .02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _width * 0.75,
                child: Text(
                  widget.postItem.albumId!.toString(),
                  style: GoogleFonts.openSans(
                    fontSize: _height * .02,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8F9090),
                    letterSpacing: 0.04,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
              Text(
                "",
                style: GoogleFonts.openSans(
                  //fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff27AE60),
                  letterSpacing: 0.04,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height * .02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Title",
                style: GoogleFonts.openSans(
                  fontSize: _height * .02,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff8F9090),
                  letterSpacing: 0.04,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height * .015,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: _width * .8,
                child: Text(
                  widget.postItem.title!,
                  style: GoogleFonts.openSans(
                    fontSize: _height * 0.018,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8F9090),
                    letterSpacing: 0.04,
                  ),
                  softWrap: true,
                  maxLines: 6,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: _height * .17,
        ),


      ]),
    );
  }



}
