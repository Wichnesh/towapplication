import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../Utils/constant.dart';
import '../utils/pref_manager.dart';
import 'package:http/http.dart' as http;



class RequestHttp {
  final String? url;
  final dynamic body;
  final String token;
  RequestHttp({this.url, this.body,required this.token});

  Future<http.Response> post() async {

    if (kDebugMode) {
      print(
          'REQUEST DATA :-   URL IS = $url || body = ${json.encode(body)}  || Bearer $token ');
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

  Future<http.Response> get() async {

    if (kDebugMode) {
      print(
          'REQUEST DATA :-   URL IS = $url || body = ${json.encode(body)}  || Bearer $token ');
    }

    try {
      http.Response response = await http.get(
        Uri.parse(url!),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
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
