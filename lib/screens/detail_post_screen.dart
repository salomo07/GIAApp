import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:giar/global.dart';
import 'package:giar/main.dart';
import 'package:giar/theme/app_theme.dart';
import '../theme/design_course_app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class DetailPostScreen extends StatefulWidget {
  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
  var _controller;
  var jsonData;
  DetailPostScreen({Key? key,this.jsonData=""}): super(key: key);
}

class _DetailPostScreenState extends State<DetailPostScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    print(widget.jsonData);
    try
    {
      widget._controller= YoutubePlayerController(
        initialVideoId: Global.convertUrlToId("https://www.youtube.com/watch?v=7tNtU5XFwrU"),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } catch (error) {
      return ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor("#738AE6"),
      statusBarBrightness: Brightness.light,
    ));
    var media=null;
    if(widget.jsonData['youtube']!="" || widget.jsonData['image']!=""){
      media=Column(
          children: [
            widget.jsonData['youtube']!=""?HtmlWidget(widget.jsonData['youtube'],webView: true):HtmlWidget(widget.jsonData['image'],webView: true),
            Padding(padding: EdgeInsets.only(bottom: 16),),
            HtmlWidget(widget.jsonData['content'])
          ]
      );
    }
    else{media=HtmlWidget(widget.jsonData['content']);}

    return Container(
      padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top),
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            SingleChildScrollView(
                padding:EdgeInsets.all(24),
                child: media
            ),
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
