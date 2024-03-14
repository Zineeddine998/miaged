import 'package:flutter/material.dart';

class User {
  String id;
  String login;
  String password;
  String birthday;
  String address;
  int postalCode;
  String city;

  User({
    required this.id,
    required this.login,
    required this.password,
    required this.birthday,
    required this.address,
    required this.postalCode,
    required this.city,
  });


  set setId(String value) {
    id = value;
  }

  set setLogin(String value) {
    login = value;
  }

  set setPassword(String value) {
    password = value;
  }

  set setBirthday(String value) {
    birthday = value;
  }

  set setAddress(String value) {
    address = value;
  }

  set setPostalCode(int value) {
    postalCode = value;
  }

  set setCity(String value) {
    city = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': login,
      'password': password,
      'birthday': birthday,
      'address': address,
      'postalCode': postalCode,
      'city': city,
    };
  }


}
