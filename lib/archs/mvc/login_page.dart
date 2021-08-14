import 'package:architeture/archs/mvc/login_controller.dart';
import 'package:architeture/archs/mvc/login_repository.dart';
import 'package:architeture/home_page.dart';
import 'package:flutter/material.dart';

class LoginPageMVC extends StatefulWidget {

  @override
  _LoginPageMVCState createState() => _LoginPageMVCState();
}

class _LoginPageMVCState extends State<LoginPageMVC> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 
  LoginController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = LoginController(LoginRepository());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loginSucess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage())
    );
  }

  _loginError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar( 
      content: Text('Login Error'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(''),),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email'
                ),
                onSaved: controller.userEmail,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }

                  if(!value.contains('@')) {
                    return 'E-mail não é válido!';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password'
                ),
                onSaved: controller.userPassword,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }

                  return null;
                },
              ),
              SizedBox(height: 30,),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 80),
                textColor: Colors.blue,
                child: Text('ENTER'),
                onPressed: isLoading ? null : () async {
                  setState(() {
                    isLoading = true;
                  });

                  if(await controller.login()) {
                    _loginSucess();
                  } else {
                    _loginError();
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}