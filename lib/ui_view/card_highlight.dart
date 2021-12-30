import '../theme/app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../screens/detail_post_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardHighLightView extends StatefulWidget{
  @override
  _CardHighLightViewState createState() =>_CardHighLightViewState();
  var jsonData;
//  String title,body,author,times;
  int id=0;

  CardHighLightView({Key? key,this.jsonData=""}): super(key: key);
}

class _CardHighLightViewState extends State<CardHighLightView>{

  @override
  Widget build(BuildContext context) {
    print(widget.jsonData['title']);
    if(widget.jsonData['title']=="Loading data ...")
    {
      return Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28.0),
                bottomLeft: Radius.circular(28.0),
                bottomRight: Radius.circular(28.0),
                topRight: Radius.circular(28.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Column(children:[
                      Text(widget.jsonData['title'],overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18,color: AppTheme.nearlyDarkBlue,fontWeight: FontWeight.w500,fontFamily: AppTheme.fontName))]
                    )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16,bottom: 16),
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      );
    }
    else if(widget.jsonData['title']=="Failed to load data")
    {
      return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor('#fceba7'),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0),topRight: Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: AppTheme.grey.withOpacity(0.2),offset: Offset(1.1, 1.1),blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Column(children:[
                      Text(widget.jsonData['title'],overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18,color: AppTheme.nearlyDarkBlue,fontWeight: FontWeight.w500,fontFamily: AppTheme.fontName))]
                    )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    else
    {
      if(widget.jsonData['youtube'] !="" || widget.jsonData['image'] !=""){
        var imageURL="";
//          print(widget.jsonData['youtube']);
        var stringURL=RegExp(r'embed\/([\w+\-+]+)[\"\?]').allMatches(widget.jsonData['youtube']);
        var stringURLx=RegExp(r'').stringMatch(widget.jsonData['youtube']);
        for (var m in stringURL) {
          imageURL="https://img.youtube.com/vi/"+m[1].toString()+"/0.jpg";
        }
        print(imageURL);

        return Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 8, bottom: 16),
          child: InkWell(
            splashColor: Colors.blue,
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPostScreen(jsonData:widget.jsonData)));},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        imageURL!=""?Image.network(imageURL):HtmlWidget(widget.jsonData['image']),
                        Container(
                          padding:EdgeInsets.only(top: 5,bottom: 5),
                          color: Color(0xFFFFFFFF),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Padding(padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(widget.jsonData['title'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: AppTheme.nearlyDarkBlue,overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: HexColor('#54D3C2'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
      else{
        return Padding(
            padding: const EdgeInsets.only(
                left: 24, right: 24, top: 16, bottom: 18),
            child: InkWell(
              onTap: (){ print("Sedang tap");
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPostScreen(jsonData:widget.jsonData)));
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <HexColor>[
                      HexColor("#b0fffd"),
                      HexColor("#dcf5f4"),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0),bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0),topRight: Radius.circular(28.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(child:
                          Column(children:[
                            Text(widget.jsonData['title'],overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18,color: AppTheme.nearlyDarkBlue,fontWeight: FontWeight.w500,fontFamily: AppTheme.fontName))]
                          )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: Container(height: 1,decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                    ),
                    Padding(
                        padding: EdgeInsets.all(16),
                        child:SizedBox(height: 150,child:
                        SingleChildScrollView(padding: EdgeInsets.all(16),child:
                        HtmlWidget(widget.jsonData['content_short'],webView: true,onLoadingBuilder:(context, element, loadingProgress)=>CircularProgressIndicator()
                        )
                        )
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(height: 1,decoration: BoxDecoration(color: AppTheme.grey,borderRadius: BorderRadius.all(Radius.circular(4.0)))),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                        child: Row(children:
                        <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Posted by",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    widget.jsonData['author']['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        widget.jsonData['time'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                        ))
                  ],
                ),
              ),
            )
        );
      }
    }
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
