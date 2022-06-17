import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
  // int _counter = 0;
  // int get counter => _counter;

  // void increment() {
  //   _counter++;
  //   prefs.setInt('counter', _counter);
  //   notifyListeners();
  // }

  // void decrement() {
  //   _counter--;
  //   prefs.setInt('counter', _counter);
  //   notifyListeners();
  // }

  // void reset() {
  //   _counter = 0;
  //   prefs.clear();
  //   notifyListeners();
  // }

  late SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  SharedPrefProvider() {
    setup();
  }

  Future<void> setup() async {
    _prefs = await SharedPreferences.getInstance();
    // _counter = prefs.getInt('counter') ?? 0;

    // _valueLoginState = prefs.getBool(loginState) ?? false;
    // _valueLoginId = prefs.getString(loginId) ?? '';
    notifyListeners();
  }

  // keyword
  String loginState = 'loginState';
  String loginId = 'loginId';

  // value

  bool _statusAbsen = false;
  int _countCollection = 0;
  int _countPersonal = 0;
  int _todo = 0;
  int _review = 0;
  int _selesai = 0;
  String _nama = '';
  String _position = '';

  // value getter
  bool get valueLoginState {
    return prefs.getBool(loginState) ?? false;
  }

  String get valueLoginId {
    return prefs.getString(loginId) ?? '';
  }

  String get ipAddress {
    return prefs.getString('IpAddress') ?? '127.0.0.1';
  }

  bool get statusAbsen => _statusAbsen;
  int get countCollection => _countCollection;
  int get countPersonal => _countPersonal;
  int get todo => _todo;
  int get review => _review;
  int get selesai => _selesai;
  String get nama => _nama;
  String get position => _position;

  // value setter
  void setLoginState(bool value) {
    prefs.setBool(loginState, value);
    notifyListeners();
  }

  void setLoginId(String value) {
    prefs.setString(loginId, value);
    notifyListeners();
  }

  Future<void> setIpAddress(String value) async {
    prefs.setString('IpAddress', value);
    notifyListeners();
  }

  void login(String loginId, bool loginState){
    prefs.setBool(this.loginState, loginState);
    prefs.setString(this.loginId, loginId);
    notifyListeners();
  }

  void getHome(List<dynamic> json) {
    _statusAbsen = json[0]['attendance'];
    _countCollection = json[0]['countCollection'];
    _countPersonal = json[0]['countPersonal'];

    _todo = json[0]['todo'];
    _review = json[0]['review'];
    _selesai = json[0]['selesai'];

    _nama = json[0]['nama'];
    _position = json[0]['posisi'];
    // notifyListeners();
  }

  void postAbsen() {
    _statusAbsen = true;
    notifyListeners();
  }

  void logout() {
    prefs.clear();
    notifyListeners();
  }

  // debug management
  bool debugState = true;
  bool loginDirect = false;
}
