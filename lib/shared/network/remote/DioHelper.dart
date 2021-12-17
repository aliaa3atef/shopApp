import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDate({
    @required String url,
    Map<String, dynamic> query,
    String token,
    String lang = "en",
  }) async {

    dio.options.headers =
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token??"",
    };

    return await dio.get(url, queryParameters: query??null );
  }

  static Future<Response> postData(
      {@required String url,
      Map<String, dynamic> query,
      String token,
      String lang = "en",
      @required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type' : 'application/json',
      'lang' : lang,
      'Authorization' : token??"",
    };

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {@required String url,
        Map<String, dynamic> query,
        String token,
        String lang = "en",
        @required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type' : 'application/json',
      'lang' : lang,
      'Authorization' : token??"",
    };

    return await dio.put(url, queryParameters: query, data: data);
  }

}
