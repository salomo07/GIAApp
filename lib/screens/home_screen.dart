import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giar/main.dart';
import 'package:badges/badges.dart';

import '../global.dart';
import '../ui_view/card_highlight.dart';
import '../ui_view/body_measurement.dart';
import '../ui_view/glass_view.dart';
import '../ui_view/meals_list_view.dart';
import '../ui_view/title_view.dart';
import '../theme/app_theme.dart';


class HomeScreen extends StatefulWidget {
  final AnimationController? animationController;
  const HomeScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: widget.animationController!,curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    print("Sedang init : Home Screen");
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(titleTxt: 'Warta Jemaat',subTxt: 'Baca lainnya...'),
    );
    listViews.add(
        FutureBuilder(
            future: Global.fetchData('posts?categories=1&filter[orderby]=date&order=desc&per_page=1&_embed'),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                var data=snapshot.data;
                return CardHighLightView(jsonData: data[0]);
              }
              if(snapshot.hasError){return CardHighLightView(jsonData:{"title":"Failed to load data","body":"...","author":"...","time":"..."});}
              else{
                return CardHighLightView(jsonData:{"title":"Loading data ...","body":"...","author":"...","time":"..."});;
              }
            })
    );
    listViews.add(
        FutureBuilder(
            future: Global.fetchData('posts?categories=2&filter[orderby]=date&order=desc&per_page=1&_embed'),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                var data=snapshot.data;
                return CardHighLightView(jsonData: data[0]);
              }
              if(snapshot.hasError){return CardHighLightView(jsonData:{"title":"Failed to load data","body":"...","author":"...","time":"..."});}
              else{
                return CardHighLightView(jsonData:{"title":"Loading data ...","body":"...","author":"...","time":"..."});;
              }
            })
    );
//    listViews.add(
//        FutureBuilder(
//            future: Global.fetchData('posts?categories=2&filter[orderby]=date&order=desc&per_page=1&_embed'),
//            builder: (BuildContext context,AsyncSnapshot snapshot){
//              if(snapshot.hasData){
//                var data=snapshot.data;
//                return CardHighLightView(id:data[0]['id'],title:data[0]['title'],body: data[0]['content_short'],author: data[0]['author']['name'],times:data[0]['time']);
//              }
//              if(snapshot.hasError){return CardHighLightView(title:"Failed to load data",body: "...",author: "",times:"");}
//              else{
//                return CardHighLightView(title:"Loading data ...",body: "...",author: "",times:"");;
//              }
//            })
//    );
    listViews.add(
      TitleView(titleTxt: 'Kategori',subTxt: 'Baca lainnya...'),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
          titleTxt: 'Body measurement',
          subTxt: 'Today'
      ),
    );

    listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Water',
        subTxt: 'Aqua SmartBottle',
      ),
    );

    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getTopBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController?.forward();
        return listViews[index];
      },
    );
  }

  Widget getTopBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#738AE6').withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22)
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child:
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.transparent),borderRadius:BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22)),
                        boxShadow: [BoxShadow(color: HexColor('#738FE6'), spreadRadius: 2)]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,top: 12 - 8.0 * topBarOpacity,bottom: 12 - 8.0 * topBarOpacity),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(

                                            child: Image.asset('assets/images/tab_1s.png',fit: BoxFit.cover,width: 45,height: 45,),
                                          ),
                                          SizedBox(width: 15,),
                                          Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                // color: Colors.red,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Hello jemaat,", style: TextStyle(color: Colors.white, fontSize: 13),),
                                                    SizedBox(height: 5,),
                                                    Text("GIA Rajawali", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                                                  ],
                                                ),
                                              )
                                          ),
                                          SizedBox(width: 15,),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(1, 1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            // child: Icon(Icons.notifications_rounded)
                                            child: Badge(
                                                padding: EdgeInsets.all(3),
                                                position: BadgePosition.topEnd(top: -5, end: 2),
                                                badgeContent: Text('', style: TextStyle(color: Colors.white),),
                                                child: Icon(Icons.notifications_rounded)
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),) ,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
