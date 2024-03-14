import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'User.dart';


class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

    Future<void> updateUser(User updatedUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(_user!.id)
          .update(updatedUser.toMap());
      _user = updatedUser;
      notifyListeners();
    } catch (error) {
      print('Error updating user: $error');
    }
  }
}
