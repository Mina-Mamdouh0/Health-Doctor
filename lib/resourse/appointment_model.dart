
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel{
  String? uid;
  Timestamp? createdAt;
  String? uidDoc;
  String? uidPoint;
  String? ageDoc;
  String? nameDoc;
  String? time;
  String? date;

  AppointmentModel(
      { this.createdAt,
        this.date,
        this.uid,
        this.ageDoc,
        this.nameDoc,
        this.time,
        this.uidDoc,
        this.uidPoint,
      });

  factory AppointmentModel.jsonDate(date){
    return AppointmentModel(
      uidPoint: date['UidPoint'],
      uidDoc: date['UidDoc'],
      time: date['Time'],
      nameDoc: date['NameDoc'],
      createdAt: date['CreatedAt'],
      ageDoc: date['AgeDoc'],
      uid: date['Uid'],
      date: date['Date'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UidPoint':uidPoint,
      'UidDoc':uidDoc,
      'Time':time,
      'NameDoc':nameDoc,
      'CreatedAt':createdAt,
      'AgeDoc':ageDoc,
      'Uid':uid,
      'Date':date,
    };
  }
}