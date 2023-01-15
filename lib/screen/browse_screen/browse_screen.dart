import 'package:flutter/material.dart';
import 'package:movie_app/shared/style/myColor.dart';

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container();
            },
            separatorBuilder: (context, index) =>
                Divider(color: MyColor.greyColor, thickness: 1),
            itemCount: 4,
          ),
        ),
      ],
    );
  }
}
