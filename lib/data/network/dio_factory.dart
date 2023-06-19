import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_prefs.dart';
import '../../app/constants.dart';

const String aPPLICATION_JSON = 'application/json';
const String cONTENT_TYPE = 'content-type';
const String aCCEPT = 'accept';
const String aUTHORIZATION = 'authorization';
const String dEFAULT_LANGUAGE = 'language';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      cONTENT_TYPE: aPPLICATION_JSON,
      aCCEPT: aPPLICATION_JSON,
      aUTHORIZATION: Constants.token,
      dEFAULT_LANGUAGE: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      sendTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      // receiveTimeout: Constants.apiTimeOut,
      // sendTimeout: Constants.apiTimeOut,
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      // print('no logs release mode');
      // } else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}
