import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/feature/model/car_type_model.dart';
import 'package:auction_app/feature/model/city_model.dart';
import 'package:auction_app/feature/model/noplace_model.dart';
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

  List<String> idCityToChoices = [];
  List<String> selectedCityChoices = [];

  List<String> idCarTypeToChoices = [];
  List<String> selectedCarTypeChoices = [];

  @override
  initState() {
    super.initState();

    homepageRepository = sl<HomepageRepository>();

    getListCategory();
    getList();
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

  void getList() async {
    // showLoading = true;
    // uiLoading = true;

    searchEditingController = TextEditingController();
    locationEditingController = TextEditingController();
    // await Future.delayed(const Duration(seconds: 1));

    var response = await homepageRepository.getDataList(100, currentPage + 1);

    if (response is DataSuccess) {
      noplaces = response.data?.listViewBienSo;

      totalItem = response.data?.rowCout;

      numPage = response.data?.pageCount;
    }
    // noplaces = await NoPlaceModel.getDummyList();

    showLoading = false;
    uiLoading = false;

    update();
  }

  void searchList(String value, String tenTinh) async {
    searchText = value;
    searchEditingController = TextEditingController(text: value);
    locationEditingController = TextEditingController();
    // await Future.delayed(const Duration(seconds: 1));
    var response;
    if (value.isEmpty && tenTinh.isEmpty) {
      response = await homepageRepository.getDataList(100, currentPage + 1);
    } else {
      response = await homepageRepository.searchDataList(
          100, currentPage + 1, value, "", "", "", "", tenTinh);
    }

    if (response is DataSuccess) {
      noplaces = response.data?.listViewBienSo;

      totalItem = response.data?.rowCout;

      numPage = response.data?.pageCount;
    }
    // noplaces = await NoPlaceModel.getDummyList();

    showLoading = false;
    uiLoading = false;

    update();
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeEndDrawer() {
    scaffoldKey.currentState?.openDrawer();

    for (var item in selectedCityChoices) {
      String id =
          citymodels!.where((element) => element.tenTinh == item).first.maTinh;

      idCityToChoices.add(id);
    }

    searchList(searchEditingController.text, idCityToChoices.join(","));
  }

  void clearDrawer() {
    selectedCityChoices = [];
    idCityToChoices = [];
    update();
  }

  void addCityChoice(String item) {
    selectedCityChoices.add(item);
    update();
  }

  void removeCityChoice(String item) {
    selectedCityChoices.remove(item);
    update();
  }

  void addCarTypeChoice(String item) {
    selectedCarTypeChoices.add(item);
    update();
  }

  void removeCarTypeChoice(String item) {
    selectedCarTypeChoices.remove(item);
    update();
  }

  void openLocationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => const NoPlaceDialog());
  }

  @override
  String getTag() {
    return "home_page_controller";
  }
}
