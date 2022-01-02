import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Global{
  String cleaningString(data){
    var arrPattern=[RegExp(r"(<iframe .*?>)(</iframe>)"),RegExp(r"(<img .*?/>)"),RegExp(r"(<strong></strong>)")];
    var str=data;
    for(var pat in arrPattern){
      str=str.replaceAll(pat, '').toString();
    }
    return str;
  }

  String getTagHTML(data,pattern){
    return pattern.stringMatch(data)==null?"":pattern.stringMatch(data);
  }
  static fetchData(url) async {
    try{
    var baseUrl='https://gia007.000webhostapp.com/wp-json/wp/v2/';
    print(baseUrl+url);
    final response = await http.get(Uri.parse(baseUrl+url));

    if (response.statusCode == 200) {
      var jsonResult=jsonDecode(response.body);
      var res =[];
//      print(json.decode(jsonResult));
      if(url.contains('posts')){
        jsonResult.forEach((val){
          var content=val['content']['rendered'];
          var cleanContent=Global().cleaningString(content);
          print("*************************************************************");
//          print(cleanContent);
          var objRes={"id":val['id'],"title":val['title']['rendered'],"excerpt":val['excerpt']['rendered'],
            "content":cleanContent,"content_short":cleanContent.substring(0,250),
            "youtube":Global().getTagHTML(content,RegExp(r"(<iframe .*?>)(</iframe>)")),
            "image":Global().getTagHTML(content,RegExp(r"(<img .*?/>)")),
            "author":{"name":val['_embedded']['author'][0]['name'],"link":val['_embedded']['author'][0]['link']},
            "time":DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.parse(val['date']))};
          res.add(objRes);
        });
      }
      return res;
    }
    else {
      print("Ada error om !!!");
      throw Exception('Failed to fetching data');
    }
    }on TimeoutException catch (e) {
      print("Error"+e.toString());
      throw Error();
    }
  }

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1).toString();
    }

    return "";
  }
}