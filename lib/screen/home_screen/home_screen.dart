import 'package:flutter/material.dart';
import 'package:movie_app/screen/home_screen/release_widget/release_item.dart';

import 'popular_widget/popular_widget.dart';
import 'recomended_widget/recomended_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 2,
          child: PopularWidget(),
        ),
        Expanded(
          child: ReleaseItem(),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: RecomendedWidget(),
        ),
      ],
    );
  }
}
