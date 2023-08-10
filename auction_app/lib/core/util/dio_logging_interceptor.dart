// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:auction_app/utils/config/flavor_config.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (FlavorConfig.instance!.flavor == Flavor.DEVELOPMENT) {
      print(
          "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}");
      print('Headers:');
      options.headers.forEach((k, v) => print('$k: $v'));
      if (options.queryParameters != null) {
        print('queryParameters:');
        options.queryParameters.forEach((k, v) => print('$k: $v'));
      }
      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print(
          "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    }

    // example for add header authorization
    /*if (options.headers.containsKey(requiredToken)) {
      options.headers.remove(requiredToken);
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }*/
    return options;
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (FlavorConfig.instance!.flavor == Flavor.DEVELOPMENT) {
      print(
          "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
      print('Headers:');
      response.headers.forEach((k, v) => print('$k: $v'));
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (FlavorConfig.instance!.flavor == Flavor.DEVELOPMENT) {
      print(
          "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
      print("${err.response != null ? err.response!.data : 'Unknown Error'}");
      print('<-- End error');
    }
    return super.onError(err, handler);
  }
}
