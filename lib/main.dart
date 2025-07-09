import 'package:flutter/material.dart';
import 'package:pos/pages/dashboard/dashboard_view.dart';
import 'package:pos/pages/login/login_view.dart';
import 'package:pos/sidebar/sidebar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pos/state_global/state_global.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); // Ganti sesuai locale
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GlobalLoadingState())],
      child: MyApp(),
    ),
  );
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
