import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class NetworkingSolider {
  Uri url;
  NetworkingSolider(this.url);

  Future<dynamic> fetchfromwebsite() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint('successful fetching');
      String result = response.body;
      Map data = jsonDecode(result);
      debugPrint(data.toString());

      return jsonDecode(result);
    } else {
      debugPrint('failed fetching : ${response.statusCode.toString()}');
      return Future.error(
          'Error ${response.statusCode.toString()} failed to reach Data');
    }
  }
}
