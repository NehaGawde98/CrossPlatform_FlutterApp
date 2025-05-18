import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/booklist.dart';

class BookstoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookstore App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
