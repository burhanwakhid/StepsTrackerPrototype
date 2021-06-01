import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker/core/service/sharedpreferences/sharedpref_service.dart';
import 'package:steps_tracker/feature/login/data/models/history_point_model.dart';
import 'package:steps_tracker/feature/login/data/models/list_reward_model.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

class FirestoreDataSource {
  final SharedPrefService sharedPrefService;

  var _userRefs = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

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

  var _itemReward = FirebaseFirestore.instance
      .collection('item_reward')
      .withConverter<ListRewardModel>(
        fromFirestore: (snapshots, _) =>
            ListRewardModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  FirestoreDataSource(this.sharedPrefService);

  Future<UserModel> getUser(String id, String nama, int steps) async {
    try {
      var user = await _userRefs
          .doc(id.toString())
          .get()
          .then((snapshot) => snapshot.data()!)
          .catchError((onError) async {
        // add user to firestore
        print('add usser to firestore');
        await _userRefs.doc(id).set(UserModel(
            id: id,
            nama: nama,
            totalStep: 0,
            point: 0,
            initialStep: steps,
            createdAt: Timestamp.now()));
        return UserModel(
            id: id,
            nama: nama,
            point: 0,
            createdAt: Timestamp.now(),
            initialStep: steps,
            totalStep: 0);
      });

      return user;
    } catch (e) {
      print('error: ${e.toString()}');
      throw e;
    }
  }

  Future<UserModel> getDetailUser() async {
    try {
      var dataUser = await sharedPrefService.getDataUser();
      var user = await _userRefs
          .doc(dataUser.id.toString())
          .get()
          .then((snapshot) => snapshot.data()!);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTotalStep(int steps) async {
    try {
      var dataUser = await sharedPrefService.getDataUser();
      await _userRefs.doc(dataUser.id).update(
        {
          'total_step': steps - dataUser.initialStep,
        },
      );

      // var user = await _userRefs.doc(dataUser.id).get().then((snapshot) async {
      //   return snapshot.data()!;
      // });

      // var pointUser = (user.totalStep / 10).floor();

      // // call method to update point user
      // await updatePoint(pointUser, dataUser.id);

      // update point and add history point
      _userRefs.snapshots().listen((event) async {
        event.docChanges.forEach((element) async {
          var item = element.doc.data();

          var pointUser = (item!.totalStep / 10).floor();

          // call method to update point user
          await updatePoint(pointUser, dataUser.id);
        });
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updatePoint(int point, String idUser) async {
    try {
      await _userRefs.doc(idUser).update(
        {
          'point': point,
        },
      );
      // var user = await _userRefs.doc(idUser).get().then((snapshot) async {
      //   return snapshot.data()!;
      // });

      // var newPoint = user.point;
      // if (newPoint - point != 0)
      //   await addHistoryPoint(idUser, newPoint - point);

      _userRefs.snapshots().listen((event) async {
        event.docChanges.forEach((element) async {
          var item = element.doc.data();

          var newPoint = item!.point;
          if (newPoint - point != 0)
            await addHistoryPoint(idUser, newPoint - point);
        });
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addHistoryPoint(String idUser, int point) async {
    try {
      print('post');
      await _historyPointRefs.doc().set(
            HistoryPointModel(
              id: idUser,
              point: point,
              createdAt: Timestamp.now(),
            ),
          );
    } catch (e) {
      throw e;
    }
  }

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

  Future<List<HistoryPointModel>> getHistoryPoint() async {
    try {
      var dataUser = await sharedPrefService.getDataUser();
      var item = await _historyPointRefs
          .where('id_user', isEqualTo: dataUser.id)
          .get();
      // return item;
      var documents = item.docs;

      List<HistoryPointModel> listData = <HistoryPointModel>[];

      documents.forEach((element) {
        var data = element.data();
        listData.add(data);
      });

      return listData;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ListRewardModel>> getListReward() async {
    try {
      var item = await _itemReward.get();
      // return item;
      var documents = item.docs;

      List<ListRewardModel> listData = <ListRewardModel>[];

      documents.forEach((element) {
        var data = element.data();
        listData.add(data);
      });

      return listData;
    } catch (e) {
      throw e;
    }
  }
}
