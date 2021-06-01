import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker/core/service/sharedpreferences/sharedpref_service.dart';
import 'package:steps_tracker/feature/login/data/models/history_point_model.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

class FirestoreTransactionDataSource {
  final SharedPrefService sharedPrefService;

  var _userRefs2 = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  var _historyPointRefs = FirebaseFirestore.instance
      .collection('history_point')
      .withConverter<HistoryPointModel>(
        fromFirestore: (snapshots, _) =>
            HistoryPointModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  FirestoreTransactionDataSource(this.sharedPrefService);

  Future<void> buyReward(int price) async {
    try {
      var dataUser = await sharedPrefService.getDataUser();
      var user = await _userRefs2.doc(dataUser.id).get().then((snapshot) async {
        return snapshot.data()!;
      });

      if (user.point < price) {
        throw 'your point are lacking';
      }

      await _userRefs2.doc(dataUser.id).update(
        {
          'point': user.point - price,
        },
      );
      print('jiji');

      await _historyPointRefs.doc().set(
            HistoryPointModel(
              id: user.id,
              point: -price,
              createdAt: Timestamp.now(),
            ),
          );
    } catch (e) {
      throw e;
    }
  }
}
