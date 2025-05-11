import 'package:flutter/material.dart';
import '../../../Setting/models/model_image.dart';
import 'dart:async';
import 'dimensions.dart';
import 'theme_helper.dart';
class SliderImageHeaderAutoRoute extends StatefulWidget {

  SliderImageHeaderAutoRoute();

  @override
  SliderImageHeaderAutoRouteState createState() => new SliderImageHeaderAutoRouteState();
}


class SliderImageHeaderAutoRouteState extends State<SliderImageHeaderAutoRoute> {

  static const int MAX = 7;
  List<ModelImage> items = ThemeHelper.getModelImage();
  int page = 0;
  late Timer timer;
  late ModelImage curObj;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    curObj = items[0];
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      page = page + 1;
      if (page >= MAX) page = 0;
      pageController.animateToPage(page, duration: Duration(milliseconds: 200), curve: Curves.linear);
      print("animateToPage");
      setState(() {
        curObj = items[page];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(timer.isActive) timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              // elevation: 10,
              margin: EdgeInsets.all(0),
              child: Container(
                height:Dimensions.pageViewContainer,
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: pageController,
                      children: getImagesHeader(),
                      onPageChanged: onPageViewChange,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: Dimensions.height5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildDots(context)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    setState(() {});
  }

  List<Widget> getImagesHeader(){
    List<Widget> lw = [];
    for(ModelImage mi in items){
      lw.add(Image.asset(ThemeHelper.getimages(mi.image),fit: BoxFit.cover));
    }
    return lw;
  }

  Widget buildDots(BuildContext context){
    Widget widget;

    List<Widget> dots = [];
    for(int i=0; i<MAX; i++){
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 9,
        width: 9,
        decoration: BoxDecoration(
          color: page == i ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1.5)
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}

