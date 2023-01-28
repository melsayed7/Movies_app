import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/firebase_utils/firebase_utils.dart';
import 'package:movie_app/model/TopRatedMovie.dart';
import 'package:movie_app/model/WatchListModel.dart';
import 'package:movie_app/screen/movie_details/movie_details.dart';
import 'package:movie_app/shared/style/myColor.dart';

class RecomendedItem extends StatefulWidget {
  Results result;

  RecomendedItem({required this.result});

  @override
  State<RecomendedItem> createState() => _RecomendedItemState();
}

class _RecomendedItemState extends State<RecomendedItem> {
  late WatchListModel model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var isExist = await FirebaseUtils.isInWatchList(widget.result.id!);
      model.check = isExist;
      setState(() {});
    });

    model = WatchListModel(
      id: widget.result.id ?? 0,
      image: widget.result.posterPath ?? '',
      title: widget.result.title ?? '',
      content: widget.result.overview ?? '',
      date: widget.result.releaseDate ?? '',
      check: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushNamed(MovieDetails.routeName,
            arguments: await ApiManager.getMovieDetails(widget.result.id ?? 0));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff343534),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.result.posterPath}',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * .3,
                  ),
                  InkWell(
                    onTap: () {
                      if (model.check) {
                        FirebaseUtils.deleteWatchListFromFirebase(model.id);
                      } else {
                        FirebaseUtils.addWatchListToFirebase(model);
                      }
                      model.check = !model.check;
                      setState(() {});
                    },
                    child: model.check == true
                        ? Image.asset('assets/images/bookmarkDone.png')
                        : Image.asset('assets/images/bookmark.png'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset('assets/images/star.png'),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.result.voteAverage}',
                  style: TextStyle(
                    color: MyColor.whiteColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '${widget.result.title}',
              style: TextStyle(
                color: MyColor.whiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '${widget.result.releaseDate}',
              style: const TextStyle(
                color: Color(0xffB5B4B4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
