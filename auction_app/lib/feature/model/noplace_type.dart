import 'dart:convert';

import 'package:flutter/services.dart';

class NoPlaceTypeModel {
  String ma;

  String ten;

  NoPlaceTypeModel({required this.ma, required this.ten});

  factory NoPlaceTypeModel.fromJson(Map<String, dynamic> json) {
    return NoPlaceTypeModel(ma: json['ma'], ten: json['ten']);
  }

  Map<String, dynamic> toJson() => {
        "ma": ma,
        "ten": ten,
      };

  static List<NoPlaceTypeModel> getListFromJson(List<dynamic> jsonArray) {
    List<NoPlaceTypeModel> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(NoPlaceTypeModel.fromJson(jsonArray[i]));
    }
    return list;
  }
}
