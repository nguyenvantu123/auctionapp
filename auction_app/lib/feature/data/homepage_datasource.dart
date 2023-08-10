import 'dart:convert';
import 'dart:io';

import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:dio/dio.dart';
import 'package:auction_app/utils/config/base_url_config.dart';
import 'package:auction_app/utils/config/constant_config.dart';
import 'package:auction_app/utils/resources/data_state.dart';

abstract class HomePageRemoteDataSource {
  /// Calls the [baseUrl]/v2/top-headlines?category=:category&country=:country&apiKey=:apiKey endpoint
  ///
  /// Throws a [DioError] for all error codes.
  Future<DataState<NoPlaceListModel>> authen(String username, String password);

  /// Calls the [baseUrl]/v2/top-headlines?country=:country&apiKey=:apiKey&q=:q
  ///
  /// Throws a [DioError] for all error codes.
}

class LoginRemoteDataSourceImpl implements HomePageRemoteDataSource {
  final Dio dio;
  final ConstantConfig constantConfig;

  LoginRemoteDataSourceImpl({
    required this.dio,
    required this.constantConfig,
  });

  @override
  Future<DataState<NoPlaceListModel>> authen(
      String username, String password) async {
    var params = {
      'email': username,
      'password': password,
      'auditClient': 3,
    };

    Response response = await dio.post(
      RouteConfig.getListNoPlace,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    var dataResponse = NoPlaceListModel.fromJson(response.data);

    return DataSuccess(dataResponse);
  }
}
