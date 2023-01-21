import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_utils/firebase_utils.dart';
import 'package:movie_app/model/WatchListModel.dart';
import 'package:movie_app/screen/watch_list_screen/watch_list_item.dart';
import 'package:movie_app/shared/style/myColor.dart';

class WatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WatchList ',
          style: TextStyle(
            color: MyColor.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<WatchListModel>>(
        stream: FirebaseUtils.getWatchListFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          var watchList =
              snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
          return ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(color: MyColor.greyColor, thickness: 1),
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return WatchListItem(
                id: watchList[index].id,
                title: watchList[index].title,
                content: watchList[index].content,
                date: watchList[index].date,
                image: watchList[index].image,
              );
            },
            itemCount: watchList.length,
          );
        },
      ),
    );
  }
}
