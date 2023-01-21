import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/WatchListModel.dart';

class FirebaseUtils {
  static CollectionReference<WatchListModel> getWatchListCollectionRef() {
    return FirebaseFirestore.instance
        .collection('watchList')
        .withConverter<WatchListModel>(
          fromFirestore: (snapshot, options) =>
              WatchListModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addWatchListToFirebase(WatchListModel model) {
    var collection = getWatchListCollectionRef();
    var docRef = collection.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<WatchListModel>> getWatchListFromFirebase() {
    return getWatchListCollectionRef().snapshots();
  }

  static Future<void> deleteWatchListFromFirebase(WatchListModel model) async {
    return await getWatchListCollectionRef().doc(model.id).delete();
  }
}
