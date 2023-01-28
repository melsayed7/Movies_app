import 'package:flutter/material.dart';
import 'package:movie_app/screen/home_screen/release_widget/release_widget.dart';

import 'popular_widget/popular_widget.dart';
import 'recomended_widget/recomended_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 5,
          child: PopularWidget(),
        ),
        Expanded(
          flex: 3,
          child: ReleaseWidget(),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 4,
          child: RecomendedWidget(),
        ),
      ],
    );
  }
}
