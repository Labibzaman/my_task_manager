import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/lib/ui/screens/splash_screen.dart';


class TasKmanagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> NavigationKey = GlobalKey<NavigatorState>();
  const TasKmanagerApp({super.key});

  @override
  State<TasKmanagerApp> createState() => _TasKmanagerAppState();
}

class _TasKmanagerAppState extends State<TasKmanagerApp> {
  static GlobalKey<NavigatorState> NavigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationKey,
      home: splashScreen(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          primaryColor: CupertinoColors.activeGreen,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
          ))),
    );
  }
}
