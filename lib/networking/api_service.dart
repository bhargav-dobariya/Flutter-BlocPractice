import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';

import '../models/login_model.dart';

class ApiService {
  static String? deviceId;

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
  }

  static const String _userLoginUrl = "https://dev.evitalrx.in:3000/v3/login/";

  Future<LoginModel?> userLogin({String? mobile, String? password}) async {
    Map<String, dynamic> body = {
      "mobile": mobile,
      "password": password,
      "device_id": deviceId.toString(),
      "chemist_code": "0"
    };
    try {
      http.Response response = await http.post(Uri.parse(_userLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      print("Login APi Res:${response.body}");

      return LoginModel.fromJson(mapResponse);
    } catch (e) {
      return LoginModel();
    }
  }
}
