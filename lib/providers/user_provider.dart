import 'dart:async';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/authentication.dart';

class UserProvider with ChangeNotifier {
  User_h _userd = User_h(
    email: '',
    profileImage: '',
    uid: '',
    username: '',
    type:'',
  );
  final AuthMethods _authMethode = AuthMethods();
  User_h get getUser => _userd;

  Future refreshUser() async {
    User_h user = await _authMethode.getUserDetails();
    _userd = user;
    notifyListeners();
  }
}
