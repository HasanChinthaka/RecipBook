import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recepies_app/pages/home_page.dart';
import 'package:recepies_app/pages/login_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recip Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: "/login",
      routes: {
        "/login": (contex) => LoginPage(),
        "/home": (context) => HomePage(),
      },
    );
  }
}
