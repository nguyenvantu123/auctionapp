import 'package:auction_app/core/network/network_info.dart';
import 'package:auction_app/feature/data/homepage_datasource.dart';
import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:auction_app/utils/resources/data_state.dart';

class HomePageRepositoryImpl implements HomepageRepository {
  final HomePageRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  HomePageRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<DataState<NoPlaceListModel>> getDataList(
      String username, String password) {
    // TODO: implement getDataList
    throw UnimplementedError();
  }
}
