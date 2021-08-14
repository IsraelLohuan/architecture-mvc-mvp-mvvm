import 'package:architeture/archs/mvc/login_repository.dart';
import 'package:architeture/archs/mvc/user_model.dart';
import 'package:architeture/archs/mvvm/login_view_model.dart';
import 'package:architeture/home_page.dart';
import 'package:flutter/material.dart';

class LoginPageMVVM extends StatefulWidget {
  @override
  _LoginPageMVVMState createState() => _LoginPageMVVMState();
}

class _LoginPageMVVMState extends State<LoginPageMVVM> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final user = UserModel();

  LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel(LoginRepository());
    viewModel.isLoadingOut.listen((isLogin) {
      if (isLogin) {
        loginSuccess();
      } else {
        loginError();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  loginSuccess() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  loginError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Login Error'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'email'),
                onSaved: (String value) => user.email = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }

                  if (!value.contains('@')) {
                    return 'E-mail não é válido!';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'password'),
                onSaved: (String value) => user.password = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<bool>(
                  stream: viewModel.isLoadingOut,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool isLoading = snapshot.data;

                    return RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      textColor: Colors.blue,
                      child: Text('ENTER'),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }

                              _formKey.currentState.save();

                              viewModel.isLoginIn.add(user);
                            },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
