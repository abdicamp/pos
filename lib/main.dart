import 'package:flutter/material.dart';
import 'package:pos/pages/dashboard/dashboard_view.dart';
import 'package:pos/pages/login/login_view.dart';
import 'package:pos/sidebar/sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Sidebar());
  }
}
