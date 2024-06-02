
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  String ? uid;
  String ? uidChat;
  String ? name;
  String ? otherUid;
  String ? otherName;
  String ? lastMsg;
  Timestamp ? createdAt;
  Timestamp ? timeLastMsg;

  ChatModel(
      {this.uid,
      this.createdAt,
      this.lastMsg,
      this.otherUid,
      this.uidChat,
        this.name,
        this.otherName,
      this.timeLastMsg});

  factory ChatModel.jsonData(data){
    return ChatModel(
      createdAt: data['CreatedAt'],
      lastMsg: data['LastMsg'],
      otherUid: data['OtherUid'],
      timeLastMsg: data['TimeLastMsg'],
      uid: data['Uid'],
      uidChat: data['UidChat'],
      otherName: data['OtherName'],
      name: data['Name'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'CreatedAt':createdAt,
      'LastMsg':lastMsg,
      'OtherUid':otherUid,
      'Uid':uid,
      'UidChat':uidChat,
      'TimeLastMsg':timeLastMsg,
      'OtherName':otherName,
      'Name':name,
    };
  }



}