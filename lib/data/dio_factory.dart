import 'package:curd/constant/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "Accept";
const String DFAULT_LANGOUAGE = "Accept-Language";
const String AUTHORIZATION = "Authorization";
const String LANGUAGE = "Accept-Language";

class DioFactory {
  DioFactory();

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeout = 60 * 1000;
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      // LANGUAGE:language
    };
    dio.options = BaseOptions(
      baseUrl: AppConstant.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: headers,
    );

    if (kReleaseMode) {
    } else {
      dio.interceptors.add((PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      )));
    }
    return dio;
  }
}
