import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  static LocalStorageService? _instance;
  final _secureStorage = const FlutterSecureStorage();

  static SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance ??=  LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance!;
  }


  Future<Map<String,dynamic>> read(String key) async{
    var readData =    await  _secureStorage.read(key: key,
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );


    if(readData == null){
      return readData as Map<String,dynamic> ;
    }


    return  json.decode(readData) as Map<String,dynamic>;
  }

  save(String key, dynamic value) async{
    await _secureStorage.write(
        key: key, value: json.encode(value),
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );
    var re = await _secureStorage.write(
        key: key, value: json.encode(value),
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );
  }

  remove(String key)  async{
    await _secureStorage.delete(
        key: key,
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );
    await _preferences!.remove(key);
  }

  void clearData() async{
    await _secureStorage.deleteAll();
    await _preferences!.clear();
  }


  saveStringToDisk(String key, String content){
    _secureStorage.write(key: key, value: content,
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );

  }

  saveBooleanToDisk(String key, bool content) async{
    await _preferences!.setBool(key, content);

  }
  Future<bool> isLogin(String key)  async{
    var value =   _preferences!.getBool(key);
    return value ?? false ;
  }


  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key,
        aOptions: _getAndroidOptions(),
        iOptions: _iosOptions()
    );
    return containsKey ?? false;
  }

  Future<bool?> getBooleanFromDisk(String key) async{
    return await _preferences!.getBool(key);
  }
  Future<String?> getStringFromDisk(String key) async {
    try {
      var value = await _secureStorage.read(key: key,
          aOptions: _getAndroidOptions(),
          iOptions: _iosOptions()
      );
      print("value $value");
      return value;
    } catch(e){
      clearData();
      return null;
    }
  }

  AndroidOptions _getAndroidOptions() => AndroidOptions();
  IOSOptions _iosOptions() => IOSOptions();
}