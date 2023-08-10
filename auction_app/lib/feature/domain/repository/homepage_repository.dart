import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:auction_app/utils/resources/data_state.dart';

abstract class HomepageRepository {
  Future<DataState<NoPlaceListModel>> getDataList(
      String username, String password);
}
