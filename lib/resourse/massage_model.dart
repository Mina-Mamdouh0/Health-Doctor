

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String ? message;
  String ? image;
  String ? id;
  Timestamp? created;

  MessageModel({this.message, this.id,this.image,this.created});
  factory MessageModel.jsonDate(date){
    return MessageModel(
        message: date['message'],
        image: date['image'],
        created: date['created'],
        id: date['id']);
  }

  Map<String,dynamic> toMap(){
    return {
      'message':message,
      'image':image,
      'created':created,
      'id':id,
    };
  }

}