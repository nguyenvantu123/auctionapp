import 'package:auction_app/feature/model/noplace_model.dart';

class NoPlaceListModel {
  int currentPage;

  int pageCount;

  int rowCout;

  String searchQuery;

  List<NoPlaceModel> listViewBienSo = [];

  NoPlaceListModel(
      {required this.currentPage,
      required this.pageCount,
      required this.rowCout,
      required this.searchQuery,
      required this.listViewBienSo});

  factory NoPlaceListModel.fromJson(Map<String, dynamic> json) {
    return NoPlaceListModel(
        currentPage: json['currentPage'],
        pageCount: json['pageCount'],
        rowCout: json['rowCout'],
        searchQuery: json['searchQuery'],
        listViewBienSo: NoPlaceModel.getListFromJson(json['listViewBienSo']));
  }

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "pageCount": pageCount,
        "rowCout": rowCout,
        "searchQuery": searchQuery,
        "listViewBienSo": listViewBienSo,
      };
}
