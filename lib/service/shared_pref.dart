import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static getLikedData() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var likedData = sharedPreferences.getString('liked');

    likedData ??= '[]';

    return json.decode(likedData);
  }

  static likedData(data) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('liked', json.encode(data));
  }
}
