import 'package:architeture/archs/mvc/user_model.dart';

class LoginRepository {
  
  Future<bool> doLogin(UserModel user) async {
    await Future.delayed(Duration(seconds: 2));
    return user.email == 'teste@gmail.com' && user.password == '123';
  }
}