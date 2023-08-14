import 'package:auction_app/core/network/network_info.dart';
import 'package:auction_app/feature/data/homepage_datasource.dart';
import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/feature/model/category.dart';
import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:auction_app/feature/model/noplace_type.dart';
import 'package:auction_app/utils/resources/data_state.dart';

class HomePageRepositoryImpl implements HomepageRepository {
  final HomePageRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  HomePageRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<NoPlaceListModel>> getDataList(int nop, int p) async {
    var response = await loginRemoteDataSource.getDataList(nop, p);
    return response;
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
    var response = await loginRemoteDataSource.searchDataList(
        nop, p, bienSo, maLoai, maTinh, so, tenLoai, tenTinh);
    return response;
  }

  @override
  Future<DataState<CategoryModel>> getAllCategory() async {
    var response = await loginRemoteDataSource.getAllCategory();
    return response;
  }

  @override
  Future<DataState<List<NoPlaceTypeModel>>> getListNoPlaceType() async {
    var response = await loginRemoteDataSource.getListNoPlaceType();
    return response;
  }

  @override
  Future<DataState<NoPlaceListModel>> getNoplaceType(
      int nop,
      int p,
      String bienSo,
      String id,
      String maLoai,
      String maTinh,
      String so,
      String tenLoai,
      String tenTinh) async {
    var response = await loginRemoteDataSource.getNoplaceType(
        nop, p, bienSo, id, maLoai, maTinh, so, tenLoai, tenTinh);
    return response;
  }
}
