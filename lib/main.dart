import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      Permission.storage.request();
    } else {
      throw 'Уйди отсюда со своим айфоном';
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

