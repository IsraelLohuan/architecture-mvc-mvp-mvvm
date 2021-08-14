import 'package:architeture/archs/mvc/login_page.dart';
import 'package:architeture/archs/mvp/login_page.dart';
import 'package:architeture/archs/mvvm/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPageMVVM(),
    );
  }
}
