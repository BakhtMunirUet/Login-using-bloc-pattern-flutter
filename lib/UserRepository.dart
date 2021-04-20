import 'dart:convert';

import 'package:bloc_login/LocalStorage.dart';
import 'package:flutter/material.dart';

class UserRepository {
  Future<bool> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    String encodedModel =
        await LocalStorage.getStringPreferences(LocalStorage.signupUser);
    if (encodedModel == null) {
      return false;
    } else {
      Map<String, dynamic> eJson = json.decode(encodedModel);
      String eUserName = eJson['userName'];
      String ePassword = eJson['password'];
      if (eUserName == username && ePassword == password) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    LocalStorage.deletePref(LocalStorage.signupUser);
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    ///   String encodedModel =
    String encodedModel =
        await LocalStorage.getStringPreferences(LocalStorage.signupUser);
    await Future.delayed(Duration(seconds: 2));
    if (encodedModel != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> createUser({
    @required String username,
    @required String email,
    @required String mobileNumber,
    @required String password,
  }) async {
    //create User
    await Future.delayed(Duration(seconds: 1));
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = username;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['password'] = password;
    String object = json.encode(data);
    LocalStorage.saveUser(LocalStorage.signupUser, object);

    return true;
  }
}

class LoginModel {
  String userName;
  String email;
  String mobileNumber;
  String password;

  LoginModel({
    this.userName,
    this.email,
    this.mobileNumber,
    this.password,
  });
}
