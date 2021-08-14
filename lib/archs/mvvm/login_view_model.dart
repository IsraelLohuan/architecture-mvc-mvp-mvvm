import 'dart:async';

import 'package:architeture/archs/mvc/login_repository.dart';
import 'package:architeture/archs/mvc/user_model.dart';

class LoginViewModel {
  final _isLoading$ = StreamController<bool>.broadcast();
  Sink<bool> get isLoadingIn => _isLoading$.sink;
  Stream<bool> get isLoadingOut => _isLoading$.stream;

  final _isLogin$ = StreamController<UserModel>.broadcast();
  Sink<UserModel> get isLoginIn => _isLogin$.sink;
  Stream<bool> get isLoginOut => _isLogin$.stream.asyncMap(login);

  final LoginRepository repository;

  LoginViewModel(this.repository);

  Future<bool> login(UserModel user) async {
    print('call two');
    bool isLogin;
    isLoadingIn.add(true);

    try {
      isLogin = await repository.doLogin(user);
    } catch (e) {
      isLogin = false;
    }
    isLoadingIn.add(false);


    return isLogin;
  }

  dispose() {
    _isLoading$.close();
    _isLogin$.close();
  }
}
