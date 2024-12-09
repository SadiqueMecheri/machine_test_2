import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();
  static const String _guestusernameKey = "guestusername";
  static const String _registerKey = "registeruser";
  static const String _usernameKey = "username";
  static const String _deviceid = "deviceid";
  static const String _userid = "userid";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _token = "token";
//register user
  static Future<void> setFcmtoken(String token) async {
    log("token added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_token, token);
  }

  static Future<String?> getFcmtoken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_token);
  }

  //guestusername
  static Future<void> setGuestusername(String guestusername) async {
    log("guestusername added" + guestusername.toString());
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_guestusernameKey, guestusername);
  }

  static Future<String?> getGuestUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_guestusernameKey);
  }

//register user
  static Future<void> setRegisterUser(String registeruser) async {
    log("registeruser added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_registerKey, registeruser);
  }

  static Future<String?> getRegisterUser() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_registerKey);
  }

//isLoggedIn
  static Future<void> setLoggedIn(String loggedvalue) async {
    log("logged added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_isLoggedIn, loggedvalue);
  }

  static Future<String?> getLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_isLoggedIn);
  }

//username
  static Future<void> setUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }

  /// get and set deviceid
  ///

  static Future<void> setDeviceid(String deviceid) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_deviceid, deviceid);
  }

  static Future<String?> getDeviceid() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_deviceid);
  }

  static Future<void> setUserid(String userid) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userid, userid);
  }

  static Future<String?> getUserid() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userid);
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
