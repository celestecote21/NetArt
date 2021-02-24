import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiConnect extends ChangeNotifier {
  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();
  final ApiUrl = "http://li717-170.members.linode.com:5000/api/";
  Map<String, String> headers = {"content-type": "application/json"};
  FlutterSecureStorage storage;

  ApiConnect(this.storage);

  Future<bool> isNotConnect() {
    if (headers["token"] == null) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  void addToken(String token) {
    headers["Authorization"] = "Bearer " + token;
  }

  Future<dynamic> get(String url) {
    return http
        .get(this.ApiUrl + url, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data" + url + "  " + statusCode.toString());
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {body, encoding}) {
    return http
        .post(this.ApiUrl + url,
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String resBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(resBody);
    });
  }
}
