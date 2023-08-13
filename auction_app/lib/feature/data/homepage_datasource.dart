import 'dart:convert';
import 'dart:io';

import 'package:auction_app/feature/model/category.dart';
import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:dio/dio.dart';
import 'package:auction_app/utils/config/base_url_config.dart';
import 'package:auction_app/utils/config/constant_config.dart';
import 'package:auction_app/utils/resources/data_state.dart';

abstract class HomePageRemoteDataSource {
  /// Calls the [baseUrl]/v2/top-headlines?category=:category&country=:country&apiKey=:apiKey endpoint
  ///
  /// Throws a [DioError] for all error codes.
  Future<DataState<NoPlaceListModel>> getDataList(int nop, int p);

  Future<DataState<NoPlaceListModel>> searchDataList(
      int nop,
      int p,
      String bienSo,
      String maLoai,
      String maTinh,
      String so,
      String tenLoai,
      String tenTinh);

  Future<DataState<CategoryModel>> getAllCategory();

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
  Future<DataState<NoPlaceListModel>> getDataList(int nop, int p) async {
    String url = RouteConfig.getListNoPlace + "?nop=${nop}&p=${p}";
    Response response = await dio.get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));

    var dataResponse = NoPlaceListModel.fromJson(response.data);

    return DataSuccess(dataResponse);
  }

  @override
  Future<DataState<NoPlaceListModel>> searchDataList(
      int nop,
      int p,
      String bienSo,
      String maLoai,
      String maTinh,
      String so,
      String tenLoai,
      String tenTinh) async {
    //String url = RouteConfig.searchList ;

    var params = {
      'bienSo': bienSo,
      'maLoai': maLoai,
      'maTinh': maTinh,
      'so': so,
      'tenLoai': tenLoai,
      'tenTinh': tenTinh,
    };
    var dio = new Dio();

    var headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language':
          'vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      'DNT': '1',
      'Origin': 'https://daugiabiensoxe.com.vn',
      'Referer': 'https://daugiabiensoxe.com.vn/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-site',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
      'sec-ch-ua':
          '"Chromium";v="112", "Google Chrome";v="112", "Not:A-Brand";v="99"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"'
    };

    Response response = await dio.request(
      'https://api-sodep.daugiabiensoxe.com.vn/api/tracuu/so-khac?nop=${nop}&p=${p}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: json.encode(params),
    );

    var dataResponse = NoPlaceListModel.fromJson(response.data);

    return DataSuccess(dataResponse);
  }

  @override
  Future<DataState<CategoryModel>> getAllCategory() async {
    var headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language':
          'vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5',
      'Connection': 'keep-alive',
      'DNT': '1',
      'Origin': 'https://daugiabiensoxe.com.vn',
      'Referer': 'https://daugiabiensoxe.com.vn/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-site',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
      'sec-ch-ua':
          '"Chromium";v="112", "Google Chrome";v="112", "Not:A-Brand";v="99"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://api-sodep.daugiabiensoxe.com.vn/api/DanhMuc/dm-all',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    var dataResponse = CategoryModel.fromJson(response.data);

    return DataSuccess(dataResponse);
  }
}
