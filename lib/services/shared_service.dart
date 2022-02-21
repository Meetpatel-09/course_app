import 'package:shared_preferences/shared_preferences.dart';

class SharedServices {

  // to store data locally.
  // here, used to store the token and to store data if the user is sign in/up using google
  // to keep user logged in if he/she closes app
  Future getData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cache = prefs.getString(data);
    return cache;
  }
}