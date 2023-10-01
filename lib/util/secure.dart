import 'dart:core';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: avoid_classes_with_only_static_members
class Secure {
  static const _keyAccessToken = 'keyAccessToken';
  static const _keyClient = 'keyClient';
  static const _keyUid = 'keyUid';
  static const _keyUserId = 'keyUserId';
  static const _keyUserType = 'keyUserType';

  static const storage = FlutterSecureStorage();

  static Future<String?> get accessToken async =>
      Secure.storage.read(key: _keyAccessToken);
  static Future<void> setAccessToken(String value) async =>
      storage.write(key: _keyAccessToken, value: value);

  static Future<String?> get client async =>
      Secure.storage.read(key: _keyClient);
  static Future<void> setClient(String value) async =>
      storage.write(key: _keyClient, value: value);

  static Future<String?> get uid async => Secure.storage.read(key: _keyUid);
  static Future<void> setUid(String value) async =>
      storage.write(key: _keyUid, value: value);

  static Future<int?> get userId async {
    final userIdString = await Secure.storage.read(key: _keyUserId);
    return int.tryParse(userIdString!);
  }

  static Future<void> setUserId(int value) async =>
      storage.write(key: _keyUserId, value: value.toString());

  static Future<int?> get userType async {
    final userTypeString = await Secure.storage.read(key: _keyUserType);
    return int.tryParse(userTypeString!);
  }

  static Future<void> setUserType(int value) async =>
      storage.write(key: _keyUserType, value: value.toString());

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  static void setHttpResponseHeader(Map<String, dynamic> allHeaderFields) {
    log(allHeaderFields.toString());
    final accessToken = allHeaderFields['Access-Token'] as List<String>;
    final client = allHeaderFields['Client'] as List<String>;
    final uid = allHeaderFields['Uid'] as List<String>;

    setAccessToken(accessToken.first);
    setClient(client.first);
    setUid(uid.first);

    log(
      '''
      setHttpResponseHeader
      accessToken => $accessToken
      client => $client
      uid => $uid
    ''',
    );
  }
}
