import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

class SharedPrefService {
  final String _dataUser = 'dataUser';

  Future<void> setDataUser(UserModel data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_dataUser, jsonEncode(data.toJson()));
  }

  Future<UserModel> getDataUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var data = _prefs.getString(_dataUser);
    return UserModel.fromJson(jsonDecode(data!));
  }
}
