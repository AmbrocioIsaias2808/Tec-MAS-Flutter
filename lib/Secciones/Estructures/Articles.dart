
import 'package:flutter/cupertino.dart';

class Articles{

  int ID;
  int num;
  String image;
  String title;
  String content;
  int category;

  Articles({@required this.ID,@required this.num,@required this.image,@required this.title, @required this.content, this.category});

  Map<String, dynamic> toMap(){
    var map= <String, dynamic> {'ID':ID,'num':num, "title":title,'content':content, 'image':image, 'category':category};
    return map;
  }

  Articles.fromMap(Map<String, dynamic> map){
    ID=map["ID"];
    num=map["num"];
    title=map["title"];
    content=map["content"];
    image=map["image"];
    category=map["category"];
  }


}