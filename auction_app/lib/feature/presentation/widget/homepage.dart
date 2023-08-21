import 'package:auction_app/feature/model/noplace_model.dart';
import 'package:auction_app/feature/presentation/controller/home_page_controller.dart';
import 'package:auction_app/feature/presentation/shared/loading_page.dart';
import 'package:auction_app/flutx/theme/app_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:number_paginator/number_paginator.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomepageWidget>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late CustomTheme customTheme;

  late HomePageController homeController;

  late final _tabController = TabController(length: 3, vsync: this);

  bool isDark = false;

  @override
  void initState() {
    super.initState();
    homeController =
        FxControllerStore.putOrFind<HomePageController>(HomePageController());
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  List<Widget> _buildNoPlaceList() {
    List<Widget> list = [];

    if (homeController.noplaces!.isNotEmpty) {
      for (NoPlaceModel shop in homeController.noplaces!) {
        list.add(_buildNoPlace(shop));
      }
    }

    return list;
  }

  List<Widget> _buildNoHaveList() {
    List<Widget> list = [];

    list.add(FxText.labelLarge("Không có dữ liệu"));

    return list;
  }

  Widget _buildNoPlace(NoPlaceModel shop) {
    return FxContainer(
      margin: FxSpacing.bottom(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.bodyLarge(
                      "${shop.bienSo.substring(0, 3)} - ${shop.bienSo.substring(3, 6)}.${shop.bienSo.substring(6, 8)}",
                      fontWeight: 600,
                    ),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          homeController.favouriteOnClick(shop.bienSo);
                        },
                        child: FlareActor(
                          "assets/animations/rive/favorite.flr",
                          snapToEnd: false,
                          animation: homeController.indexChoose
                                      .containsKey(shop.bienSo) &&
                                  homeController.indexChoose[shop.bienSo] ==
                                      'Favorite'
                              ? 'Favorite'
                              : 'Unfavorite',
                          shouldClip: false,
                        ),
                      ),
                    ),
                  ],
                ),
                FxSpacing.height(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: theme.colorScheme.onBackground.withAlpha(140),
                      size: 16,
                    ),
                    FxSpacing.width(8),
                    Expanded(
                        child: FxText.bodySmall(
                      shop.tenTinh,
                      xMuted: true,
                    )),
                  ],
                ),
                FxSpacing.height(6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.car_rental,
                      color: theme.colorScheme.onBackground.withAlpha(140),
                      size: 16,
                    ),
                    FxSpacing.width(8),
                    Expanded(
                        child: FxText.bodySmall(
                      shop.tenLoai,
                      xMuted: true,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _endDrawer() {
    return SafeArea(
      child: Container(
        margin: FxSpacing.fromLTRB(16, 16, 50, 80),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: customTheme.card,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            color: customTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: FxSpacing.xy(16, 12),
                  color: customTheme.homemadePrimary,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: FxText(
                            "Tìm kiếm nâng cao",
                            fontWeight: 700,
                            color: customTheme.homemadeOnPrimary,
                          ),
                        ),
                      ),
                      FxContainer.rounded(
                          onTap: () {
                            homeController.closeEndDrawer();
                          },
                          paddingAll: 6,
                          color: customTheme.homemadeOnPrimary.withAlpha(80),
                          child: Icon(
                            FeatherIcons.x,
                            size: 12,
                            color: customTheme.homemadeOnPrimary,
                          ))
                    ],
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Thành phố ',
                    ),
                    Tab(
                      text: 'Loại xe',
                    ),
                    Tab(
                      text: 'Loại biển',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Tab(
                          child: ListView(
                        padding: FxSpacing.all(16),
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _buildCity(),
                          ),
                          FxSpacing.height(24),
                        ],
                      )),
                      Tab(
                          child: ListView(
                        padding: FxSpacing.all(16),
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _buildCarType(),
                          ),
                          FxSpacing.height(24),
                        ],
                      )),
                      Tab(
                          child: ListView(
                        padding: FxSpacing.all(16),
                        children: [
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _buildNoPlaceType(),
                          ),
                          FxSpacing.height(24),
                        ],
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: FxContainer(
                      onTap: () {
                        homeController.clearDrawer();
                      },
                      padding: FxSpacing.y(12),
                      child: Center(
                        child: FxText(
                          "Xoá bộ lọc",
                          color: customTheme.homemadeSecondary,
                          fontWeight: 600,
                        ),
                      ),
                    )),
                    Expanded(
                        child: FxContainer.none(
                      onTap: () {
                        homeController.closeEndDrawer();
                      },
                      padding: FxSpacing.y(12),
                      color: customTheme.homemadePrimary,
                      child: Center(
                        child: FxText(
                          "Áp dụng",
                          color: customTheme.homemadeOnPrimary,
                          fontWeight: 600,
                        ),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCity() {
    List<String> categoryList = [];

    List<Widget> choices = [];
    if (homeController.citymodels!.isEmpty) {
      return choices;
    }

    homeController.citymodels?.forEach((element) {
      categoryList.add(element.tenTinh);
    });

    for (var item in categoryList) {
      bool selected = homeController.selectedCityChoices.contains(item);
      if (selected) {
        choices.add(FxContainer.none(
            color: customTheme.homemadePrimary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 12,
            paddingAll: 8,
            border: Border.all(color: customTheme.homemadePrimary),
            onTap: () {
              homeController.removeCityChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: customTheme.homemadePrimary,
                ),
                FxSpacing.width(6),
                FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: customTheme.homemadePrimary,
                )
              ],
            )));
      } else {
        choices.add(FxContainer.none(
          color: customTheme.border,
          borderRadiusAll: 12,
          padding: FxSpacing.xy(12, 8),
          onTap: () {
            homeController.addCityChoice(item);
          },
          child: FxText.labelSmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }

  List<Widget> _buildCarType() {
    List<String> categoryList = [];

    List<Widget> choices = [];
    if (homeController.cartypemodels!.isEmpty) {
      return choices;
    }

    homeController.cartypemodels?.forEach((element) {
      categoryList.add(element.tenLoai);
    });

    for (var item in categoryList) {
      bool selected = homeController.selectedCarTypeChoices.contains(item);
      if (selected) {
        choices.add(FxContainer.none(
            color: customTheme.homemadePrimary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 12,
            paddingAll: 8,
            border: Border.all(color: customTheme.homemadePrimary),
            onTap: () {
              homeController.removeCarTypeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: customTheme.homemadePrimary,
                ),
                FxSpacing.width(6),
                FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: customTheme.homemadePrimary,
                )
              ],
            )));
      } else {
        choices.add(FxContainer.none(
          color: customTheme.border,
          borderRadiusAll: 12,
          padding: FxSpacing.xy(12, 8),
          onTap: () {
            homeController.addCarTypeChoice(item);
          },
          child: FxText.labelSmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }

  List<Widget> _buildNoPlaceType() {
    List<String> categoryList = [];

    List<Widget> choices = [];
    if (homeController.noplacetypemodels.isEmpty) {
      return choices;
    }

    for (var element in homeController.noplacetypemodels) {
      categoryList.add(element.ten);
    }

    for (var item in categoryList) {
      if (homeController.selectedNoPlaceTypeChoices == item) {
        choices.add(FxContainer.none(
            color: customTheme.homemadePrimary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 12,
            paddingAll: 8,
            border: Border.all(color: customTheme.homemadePrimary),
            onTap: () {
              homeController.removeNoPlaceTypeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: customTheme.homemadePrimary,
                ),
                FxSpacing.width(6),
                FxText.bodySmall(
                  item,
                  fontSize: 11,
                  color: customTheme.homemadePrimary,
                )
              ],
            )));
      } else {
        choices.add(FxContainer.none(
          color: customTheme.border,
          borderRadiusAll: 12,
          padding: FxSpacing.xy(12, 8),
          onTap: () {
            homeController.addNoPlaceTypeChoice(item);
          },
          child: FxText.labelSmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomePageController>(
        controller: homeController,
        builder: (homeController) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Scaffold(
        key: homeController.scaffoldKey,
        endDrawer: _endDrawer(),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      homeController.showLoading = true;
                      homeController.searchList(
                          value,
                          homeController.idCityToChoices.join(","),
                          homeController.idCarTypeToChoices.join(","));
                    });
                  },
                  controller: homeController.searchEditingController,
                  style: FxTextStyle.bodyMedium(),
                  cursorColor: customTheme.homemadeSecondary,
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm biển số",
                    hintStyle: FxTextStyle.bodyMedium(
                        color: theme.colorScheme.onBackground.withAlpha(150)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: Icon(
                      FeatherIcons.search,
                      size: 20,
                      color: theme.colorScheme.onBackground.withAlpha(150),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(right: 16),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                )),
                FxSpacing.width(16),
                FxContainer.bordered(
                    onTap: () {
                      homeController.openEndDrawer();
                    },
                    color: customTheme.homemadeSecondary.withAlpha(28),
                    border: Border.all(
                        color: customTheme.homemadeSecondary.withAlpha(120)),
                    borderRadiusAll: 8,
                    paddingAll: 13,
                    child: Icon(
                      FeatherIcons.sliders,
                      color: customTheme.homemadeSecondary,
                      size: 18,
                    ))
              ],
            ),
            FxSpacing.height(16),
            Expanded(
              child: (homeController.showLoading
                  ? const LoadingPage()
                  : SingleChildScrollView(
                      child: Column(
                          children: ((homeController.noplaces!.isNotEmpty
                              ? _buildNoPlaceList()
                              : _buildNoHaveList()))),
                    )),
            ),
            FxSpacing.height(5),
            NumberPaginator(
              initialPage: 0,
              numberPages: homeController.noplaces!.isNotEmpty
                  ? homeController.numPage!
                  : 1,
              onPageChange: (int index) {
                setState(() {
                  if (homeController.selectedNoPlaceTypeChoices.isNotEmpty) {
                    homeController.noplaceTypeList(
                        homeController.selectedNoPlaceTypeChoices,
                        homeController.searchText,
                        homeController.idCityToChoices.join(","),
                        homeController.idCarTypeToChoices.join(","));
                  } else if (homeController.searchText.isNotEmpty ||
                      homeController.idCityToChoices.join(",").isNotEmpty ||
                      homeController.idCarTypeToChoices.join(",").isNotEmpty) {
                    homeController.showLoading = true;
                    homeController.currentPage = index;
                    homeController.searchList(
                        homeController.searchText,
                        homeController.idCityToChoices.join(","),
                        homeController.idCarTypeToChoices.join(","));
                  } else {
                    homeController.showLoading = true;
                    homeController.currentPage = index;
                    homeController.getList();
                  }
                });
              },
            )
          ]),
        ));
  }
}
