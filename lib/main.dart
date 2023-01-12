import 'package:flutter/material.dart';
import 'package:movie_app/layout/home_layout.dart';
import 'package:movie_app/shared/style/my_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
      },
      initialRoute: HomeLayout.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
