
import 'package:flutter/cupertino.dart';

class Articles{

  int id;
  String image;
  String title;
  String content;
  int category;

  Articles({@required this.id,@required this.image,@required this.title, @required this.content, this.category});

  Map<String, dynamic> toMap(){
    var map= <String, dynamic> {'id':id, "title":title,'content':content, 'image':image, 'category':category};
    return map;
  }

  Articles.fromMap(Map<String, dynamic> map){
    id=map["id"];
    title=map["title"];
    content=map["content"];
    image=map["image"];
    category=map["category"];
  }


}