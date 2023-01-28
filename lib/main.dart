import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/layout/home_layout.dart';
import 'package:movie_app/screen/movie_details/movie_details.dart';
import 'package:movie_app/shared/style/my_theme.dart';

import 'screen/browse_screen/browse_widget_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
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
        BrowseListWidget.routeName: (context) => BrowseListWidget(),
      },
      initialRoute: HomeLayout.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
