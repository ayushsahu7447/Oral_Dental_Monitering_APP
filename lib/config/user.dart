import 'package:flutter/cupertino.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  num? mobNo;

  UserModel({this.uid, this.email, this.firstName, this.mobNo});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      mobNo: map['mobNo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'mobNo': mobNo,
    };
  }
}
