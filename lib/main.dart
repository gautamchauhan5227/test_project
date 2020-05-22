import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Post_View.dart';
import 'check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//Remove a Debug Title
      title: 'Flutter Demo',
      home: postview()
    );
  }
}

