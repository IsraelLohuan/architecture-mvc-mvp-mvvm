import 'package:architeture/archs/mvc/login_repository.dart';
import 'package:architeture/archs/mvc/user_model.dart';
import 'package:flutter/material.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  final LoginRepository repository;

  LoginController(this.repository);

  UserModel user = UserModel();

  void userEmail(String value) => user.email = value;
  void userPassword(String value) => user.password = value;

  Future<bool> login() async {
    if (!formKey.currentState.validate()) {
      return false;
    }

    formKey.currentState.save();

    try {
      return await repository.doLogin(user);
    } catch(e) {
      return false;
    }
  }
}
