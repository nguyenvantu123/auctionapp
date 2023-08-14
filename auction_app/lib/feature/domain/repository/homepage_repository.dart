import 'package:auction_app/feature/model/category.dart';
import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:auction_app/feature/model/noplace_type.dart';
import 'package:auction_app/utils/resources/data_state.dart';

abstract class HomepageRepository {
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

  Future<DataState<List<NoPlaceTypeModel>>> getListNoPlaceType();

  Future<DataState<NoPlaceListModel>> getNoplaceType(
      int nop,
      int p,
      String bienSo,
      String id,
      String maLoai,
      String maTinh,
      String so,
      String tenLoai,
      String tenTinh);
}
