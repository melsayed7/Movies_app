import 'package:flutter/material.dart';
import 'package:movie_app/layout/home_layout.dart';
import 'package:movie_app/screen/movie_details/movie_details.dart';
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
        MovieDetails.routeName: (context) => MovieDetails(),
      },
      initialRoute: HomeLayout.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
