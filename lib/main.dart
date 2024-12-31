import 'package:flutter/material.dart';
import 'router_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RouterOS Manager',
      //dark mode
      theme: ThemeData.dark(),
      //light mode
      home: const RouterListPage(),
    );
  }
}
