import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:punkapi/model/Post.dart';
import 'package:punkapi/screens/post/empty_product.dart';
import 'package:punkapi/screens/postDetails.dart';
import '../network/network_utils.dart';
import '../provider/nav_provider.dart';
import '../utils/colors.dart';
import '../utils/next_screen.dart';
import '../widgets/display_app_bar.dart';
import '../widgets/loading_indicator_widget.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Post> allPosts = [];
  List<Post> loadedPosts = [];
  int page = 10;
  bool isLoading = false;
  String defaultimage = "assets/images/logo.png";
  ConnectivityResult? connectivityResult;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: displayMobileAppBar(context, isImage: true, showAction: true, showBack: false, scaffoldKey: _scaffoldKey),
      body: Padding(
        padding: EdgeInsets.only(
            left: _screenWidth * 0.057, right: _screenWidth * 0.07),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Posts",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: _screenHeight * .03,
                    color: appColorPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _screenHeight * 0.02,
            ),
            Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: loadedPosts.length,
                  itemBuilder: (BuildContext context, int index) {

                    _scrollController.addListener(() {
                      var nextPageTrigger =
                          0.7 * _scrollController.position.maxScrollExtent;

                      if (_scrollController.position.pixels > nextPageTrigger) {
                        setState(() {
                          isLoading = true;
                        });
                        Timer(Duration(seconds: 1), () {
                          page = page + 10;
                          loadedPosts = allPosts.take(page).toList();
                          setState(() {
                            isLoading = false;
                          });
                        });

                      }
                    });

                    if (index < loadedPosts.length || index == loadedPosts.length) {
                      var _postItem = loadedPosts[index];

                      return InkWell(
                        onTap: () {
                          nextScreen(context, PostDetails(_postItem));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              _screenWidth * .01,
                              _screenHeight * .01,
                              _screenWidth * .01,
                              _screenHeight * .01),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: appWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: Offset.zero,
                                ),
                              ],
                            ),
                            width: _screenWidth * .9,
                            height: _screenHeight * .19,
                            child: Padding(
                              padding: EdgeInsets.all(_screenWidth * .03),
                              child: Row(children: [
                                _postItem.thumbnailUrl == null
                                    ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    defaultimage,
                                    height: _screenHeight * .121,
                                    width: _screenWidth * .18,
                                  ),
                                )
                                    : Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.network(
                                    _postItem.thumbnailUrl!,
                                    height: _screenHeight * .121,
                                    width: _screenWidth * .18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: _screenWidth * .06,
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      SizedBox(height: _screenHeight * .0053),
                                        Container(
                                          width: _screenWidth * 0.55,
                                          child: Text(
                                            _postItem.title!,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: _screenHeight * .02,
                                              color: Color(0xff343434),
                                            ),
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    SizedBox(height: _screenHeight * .0053),
                                        SizedBox(height: _screenHeight * .0023),
                                        Container(
                                          width: _screenWidth * 0.55,
                                          child: Text(
                                            "${_postItem.title!} ${_postItem.title!}",
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: _screenHeight * .012,
                                              color: Color(0xff8F9090),
                                            ),
                                            softWrap: true,
                                            maxLines: 4,
                                          ),
                                        ),
                                        SizedBox(height: _screenHeight * .0053),
                                      ]),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    }
                    return const Opacity(opacity: 1.0, child: LoadingIndicatorWidget());
                  },
                )),
            // LoadingIndicatorWidget()
            isLoading
                ? Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator())
                : Container(),


          ],
        ),
      ),
    );
  }


  loadPosts() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => NetworkErrorDialog(onPressed: (){
          Navigator.pop(context);
          loadPosts();
        }),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You\'re connected to a ${connectivityResult?.name} network')));
    }
    final NavProvider np = Provider.of<NavProvider>(context, listen: false);
    final baseUrl = np.postBaseUrl;
    print(baseUrl);
    try {
      var response = await getRequest(baseUrl);

      if (this.mounted) {
        if (response.statusCode == 200) {
          List? newdata = jsonDecode(response.body);
          if (newdata!.isEmpty) {
            isLoading = false;
            nextScreenReplace(context, EmptyProduct());
          }
          setState(() {
            isLoading = false;
            allPosts.addAll(newdata.map((m) => Post.fromJson(m)).toList());
            loadedPosts = allPosts.take(page).toList();
          });
        }
      }
    } catch (e) {
      isLoading = false;
      throw 'No Internet connection';
    }
  }

}

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key, this.onPressed}) : super(key: key);
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200,
              child: Image.asset('assets/images/noty.png')
          ),
          const SizedBox(height: 32),
          const Text(
            "Whoops!",
            style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "No internet connection found.",
            style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "Check your connection and try again.",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Try Again"),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
