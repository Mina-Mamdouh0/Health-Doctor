

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel{
  Timestamp ? createdAt;
  String ? name;
  String ? password;
  String ? email;
  String ? uId;
  String ? phone;
  bool ? roleIsDoc;
  String ? age;

  ProfileModel(
      { this.createdAt,
       this.password,
       this.email,
       this.uId,
        this.phone,
        this.name,
        this.roleIsDoc,
        this.age,
      });

  factory ProfileModel.jsonDate(date){
    return ProfileModel(
      uId: date['UId'],
      email: date['Email'],
      password: date['Password'],
      name: date['Name'],
      createdAt: date['CreatedAt'],
      phone: date['Phone'],
      roleIsDoc: date['RoleIsDoc'],
      age: date['Age'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Email':email,
      'UId':uId,
      'Password':password,
      'Name':name,
      'Phone':phone,
      'CreatedAt':createdAt,
      'RoleIsDoc':roleIsDoc,
      'Age':age
    };
  }
}