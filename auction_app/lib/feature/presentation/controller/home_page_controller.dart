import 'dart:collection';

import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/feature/model/car_type_model.dart';
import 'package:auction_app/feature/model/city_model.dart';
import 'package:auction_app/feature/model/noplace_list_model.dart';
import 'package:auction_app/feature/model/noplace_model.dart';
import 'package:auction_app/feature/model/noplace_type.dart';
import 'package:auction_app/feature/presentation/widget/noplace_dialog.dart';
import 'package:auction_app/injection_container.dart';
import 'package:auction_app/utils/resources/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HomePageController extends FxController {
  bool showLoading = true, uiLoading = true;

  late HomepageRepository homepageRepository;

  int currentPage = 0;

  String searchText = "";

  List<NoPlaceModel>? noplaces = [];

  int? totalItem = 0;
  int? numPage = 1;

  late TextEditingController searchEditingController;
  late TextEditingController locationEditingController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<CityModel>? citymodels = [];
  List<CarTypeModel>? cartypemodels = [];
  List<NoPlaceTypeModel> noplacetypemodels = [];

  // List<String> idCityToChoices = [];
  List<String> selectedCityChoices = [];

  // List<String> idCarTypeToChoices = [];
  List<String> selectedCarTypeChoices = [];

  String idNoPlaceTypeToChoices = "";
  String selectedNoPlaceTypeChoices = "";

  String status = "Unfavorite";

  String value = "";

  HashMap<String, String> indexChoose = HashMap<String, String>();

  @override
  initState() {
    super.initState();

    homepageRepository = sl<HomepageRepository>();

    getListCategory();
    getList();
    getListNoPlaceType();
  }

  void getListCategory() async {
    var response = await homepageRepository.getAllCategory();

    if (response is DataSuccess) {
      citymodels = response.data?.tinhThanh;

      cartypemodels = response.data?.loaiXe;
    }
    // noplaces = await NoPlaceModel.getDummyList();

    update();
  }

  void getListNoPlaceType() async {
    var response = await homepageRepository.getListNoPlaceType();

    if (response is DataSuccess) {
      noplacetypemodels = response.data!;
    }
    // noplaces = await NoPlaceModel.getDummyList();

    update();
  }

  void getList() async {
    // showLoading = true;
    // uiLoading = true;

    searchEditingController = TextEditingController();
    locationEditingController = TextEditingController();
    // await Future.delayed(const Duration(seconds: 1));
    DataState<NoPlaceListModel> response;

    searchEditingController.text = value;

    String tenTinh = citymodels!
        .where((element) => selectedCityChoices.contains(element.tenTinh))
        .toList()
        .map((element) => element.maTinh)
        .join(",");

    String maLoai = cartypemodels!
        .where((element) => selectedCarTypeChoices.contains(element.tenLoai))
        .toList()
        .map((element) => element.maLoai)
        .join(",");

    String id = "";
    if (selectedNoPlaceTypeChoices.isNotEmpty) {
      id = noplacetypemodels
          .where((element) => element.ten == selectedNoPlaceTypeChoices)
          .first
          .ma;
    }

    if (id.isNotEmpty) {
      response = await homepageRepository.getNoplaceType(
          100, currentPage + 1, value, id, maLoai, "", "", "", tenTinh);
    } else if (value.isEmpty && tenTinh.isEmpty && maLoai.isEmpty) {
      response = await homepageRepository.getDataList(100, currentPage + 1);
    } else {
      response = await homepageRepository.searchDataList(
          100, currentPage + 1, value, maLoai, "", "", "", tenTinh);
    }

    if (response is DataSuccess) {
      noplaces = response.data?.listViewBienSo;

      totalItem = response.data?.rowCout;

      numPage = response.data?.pageCount;
    }

    showLoading = false;
    uiLoading = false;

    update();
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();

    getList();
  }

  void clearDrawer() {
    selectedCityChoices = [];
    // idCityToChoices = [];

    selectedCarTypeChoices = [];
    // idCarTypeToChoices = [];

    selectedNoPlaceTypeChoices = "";
    update();
  }

  void addCityChoice(String item) {
    selectedCityChoices.add(item);
    update();
  }

  void removeCityChoice(String item) {
    selectedCityChoices.remove(item);

    // String id =
    //     citymodels!.where((element) => element.tenTinh == item).first.maTinh;

    // idCityToChoices.remove(id);
    update();
  }

  void addCarTypeChoice(String item) {
    selectedCarTypeChoices.add(item);
    update();
  }

  void removeCarTypeChoice(String item) {
    selectedCarTypeChoices.remove(item);

    // String id =
    //     cartypemodels!.where((element) => element.tenLoai == item).first.maLoai;

    // idCarTypeToChoices.remove(id);
    update();
  }

  void addNoPlaceTypeChoice(String item) {
    selectedNoPlaceTypeChoices = item;
    update();
  }

  void removeNoPlaceTypeChoice(String item) {
    selectedNoPlaceTypeChoices = "";
    update();
  }

  void openLocationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => const NoPlaceDialog());
  }

  void favouriteOnClick(String noPlace) {
    if (indexChoose.isEmpty || !indexChoose.containsKey(noPlace)) {
      indexChoose[noPlace] = "Favorite";
      update();
    } else {
      indexChoose.remove(noPlace);
      update();
    }
  }

  @override
  String getTag() {
    return "home_page_controller";
  }
}
