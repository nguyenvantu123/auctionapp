import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/utils/resources/data_state.dart';

class HomePageUseCase {
  final HomepageRepository homepageRepository;

  HomePageUseCase({required this.homepageRepository});

  Future<DataState<NoPlaceListModel>> getDataList(ParamsList params) async {
    return await homepageRepository.getDataList(params.nop, params.p);
  }

  Future<DataState<NoPlaceListModel>> searchDataList(
      ParamsSearch params) async {
    return await homepageRepository.searchDataList(
        params.nop,
        params.p,
        params.bienSo,
        params.maLoai,
        params.maTinh,
        params.so,
        params.tenLoai,
        params.tenTinh);
  }
}

class ParamsList extends Equatable {
  final int nop;
  final int p;

  ParamsList({required this.nop, required this.p});

  @override
  List<Object> get props => [nop, p];

  @override
  String toString() {
    return 'ParamsLogin {nop: $nop}, {p: $p}';
  }
}

class ParamsSearch extends Equatable {
  final int nop;
  final int p;
  final String bienSo;
  final String maLoai;
  final String maTinh;
  final String so;
  final String tenLoai;
  final String tenTinh;

  const ParamsSearch(
      {required this.nop,
      required this.p,
      required this.bienSo,
      required this.maLoai,
      required this.maTinh,
      required this.so,
      required this.tenLoai,
      required this.tenTinh});

  @override
  List<Object> get props =>
      [nop, p, bienSo, maLoai, maTinh, so, tenLoai, tenTinh];

  @override
  String toString() {
    return 'ParamsLogin {nop: $nop}, {p: $p}';
  }
}
