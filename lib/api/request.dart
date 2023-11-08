import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Utils/constant.dart';
import '../utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class RequestDio {
  final String? url;
  final dynamic body;
  final Dio dio = Dio();

  RequestDio({this.url, this.body}) {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ${Prefs.getString(TOKEN)}';
  }

  Future<Response<dynamic>> post() async {
    if (kDebugMode) {
      print('REQUEST DATA :-   URL IS = $url || body = $body  || Bearer ${Prefs.getString(TOKEN)} ');
    }
    try {
      final response = await dio.post(url!, data: body);
      return response;
    } catch (e) {
      if (e is SocketException) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else {
        if (kDebugMode) {
          print(e.toString());
        }
        throw Exception('Error occurred while making a request.');
      }
    }
  }
}


class RequestHttp {
  final String? url;
  final dynamic body;

  RequestHttp({this.url, this.body});

  Future<http.Response> post() async {
    String? token = Prefs.getString('TOKEN');

    if (kDebugMode) {
      print('REQUEST DATA :- URL IS = $url || body = ${json.encode(body)} || Bearer $token');
    }

    try {
      http.Response response = await http.post(
        Uri.parse(url!),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (kDebugMode) {
        print('RESPONSE DATA :- ${response.statusCode} || ${response.body}');
      }

      return response;
    } catch (e) {
      if (e is TimeoutException) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else {
        if (kDebugMode) {
          print(e.toString());
        }
        throw Exception('Error occurred while making a request.');
      }
    }
  }
}