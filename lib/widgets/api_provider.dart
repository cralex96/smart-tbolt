import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tbolt/user/model/user_social_auth.dart';
import 'package:device_info/device_info.dart';

class ApiProvider {
  // The name of the application
  final String _appName = "Smart TBolt";

  // The unique ID of the application
  final String _applicationId = "com.davcorp.smart_tbolt";

  // The URL of the Web Service
  final String _endpoint = "http://tbolt.local/api";

  // The storage key for the token
  final String _accessTokenKey = 'access_token';

  // The mobile device unique identity
  String _deviceIdentity = "";

  final Dio _dio = Dio();

  // Default configs for Dio requests
  final int connectTimeout = 30000;
  final int receiveTimeout = 30000;

  Future<Map> socialSignIn(UserSocialAuth userSocialAuth) async {
    final String _socialPath = '/social_auth';
    Future<Map> socialSignInResponse;
    try {
      socialSignInResponse = postRequest(_socialPath, userSocialAuth.toJson());
    } catch (error, stackTrace) {
      print("Exception ocurred: $error  stackTrace: $stackTrace");
      socialSignInResponse = jsonDecode('{"exception": $error, "stackTrace": $stackTrace}');
    }
    return socialSignInResponse;
  }

  /// ----------------------------------------------------------
  /// Method which is only run once to fetch the device identity
  /// ----------------------------------------------------------
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> _getDeviceIdentity() async {
    if (_deviceIdentity == '') {
      try {
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
          _deviceIdentity = "${info.device}-${info.id}";
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
          _deviceIdentity = "${info.model}-${info.identifierForVendor}";
        }
      } on PlatformException {
        _deviceIdentity = "unknown";
      }
    }

    return _deviceIdentity;
  }

  /// ----------------------------------------------------------
  /// Method that returns the token from Shared Preferences
  /// ----------------------------------------------------------
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_accessTokenKey) ?? '';
  }

  /// ----------------------------------------------------------
  /// Method that saves the token in Shared Preferences
  /// ----------------------------------------------------------
  Future<bool> setAccessToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(_accessTokenKey, token);
  }

  /// ----------------------------------------------------------
  /// Http "GET" request
  /// ----------------------------------------------------------
  Future<Map> getRequest(String serviceName) async {
    Map responseData = {};
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    try {
      Response response = await _dio.get(
        _endpoint + '$serviceName',
        options: Options(
          headers: {
            'X-DEVICE-ID': await _getDeviceIdentity(),
            'X-TOKEN': await getAccessToken(),
            'X-APP-ID': _applicationId
          }
        ));

      if (response.statusCode == 200) {
        responseData = response.data;
      }
    } catch (e) {
      // An error was received
      responseData = {
        'error': 'No se pudo conectar con el servidor de $_appName',
        'exception': e.toString()
      };
    }
    return responseData;
  }

  /// ----------------------------------------------------------
  /// Http "POST" request
  /// ----------------------------------------------------------
  Future<Map> postRequest(String serviceName, Map data) async {
    Map responseData = {};
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.receiveTimeout = receiveTimeout;
    try {
      Response response = await _dio.post(
        _endpoint + '$serviceName',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'X-DEVICE-ID': await _getDeviceIdentity(),
            'X-TOKEN': await getAccessToken(),
            'X-APP-ID': _applicationId,
            'Content-Type': 'application/json; charset=utf-8'
          }
        )
      );
      if (response.statusCode == 200) {
        responseData = response.data;
      }
    } catch (e) {
      // An error was received
      responseData = {
        'error': 'No se pudo conectar con el servidor de $_appName',
        'exception': e.toString()
      };
    }
    return responseData;
  }
}