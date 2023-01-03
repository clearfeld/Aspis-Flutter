import 'package:flutter/material.dart';

import 'page_main/page_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      home: const PageMain(),
    );
  }
}
