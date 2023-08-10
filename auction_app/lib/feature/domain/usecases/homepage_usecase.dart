import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/utils/resources/data_state.dart';

class HomePageUseCase {
  final HomepageRepository homepageRepository;

  HomePageUseCase({required this.homepageRepository});

  Future<DataState<NoPlaceListModel>> getDataList(ParamsLogin params) async {
    return await homepageRepository.getDataList(
        params.username, params.password);
  }
}

class ParamsLogin extends Equatable {
  final String username;
  final String password;

  ParamsLogin({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'ParamsLogin {username: $username}, {password: $password}';
  }
}
