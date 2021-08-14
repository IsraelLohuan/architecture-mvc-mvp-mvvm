import 'package:architeture/archs/mvc/login_repository.dart';
import 'package:architeture/archs/mvc/user_model.dart';
import 'package:flutter/material.dart';

abstract class LoginPageContract {
  void loginSuccess();
  void loginError();
  void loginmanager();
}

class LoginPresenter {
  final formKey = GlobalKey<FormState>();

  final LoginRepository repository;
  final LoginPageContract viewContract;

  LoginPresenter(this.viewContract, {this.repository});

  UserModel user = UserModel();

  bool isLoading = false;

  void userEmail(String value) => user.email = value;
  void userPassword(String value) => user.password = value;

  login() async {
    bool isLogin;
    isLoading = true;
    viewContract.loginmanager();

    if (!formKey.currentState.validate()) {
      isLogin = false;
    } else {
      formKey.currentState.save();

      try {
        isLogin = await repository.doLogin(user);
      } catch (e) {
        isLogin = false;
      }
    }

    isLoading = false;
    viewContract.loginmanager();
    
    if (isLogin) {
      viewContract.loginSuccess();
    } else {
      viewContract.loginError();
    }
  }
}
