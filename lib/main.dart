import 'package:agriaku_assignment/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agriaku Assignment',
      theme: themeData(),
      home: HomePage(),
    );
  }
}
