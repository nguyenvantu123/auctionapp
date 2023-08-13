import 'dart:convert';

import 'package:flutter/services.dart';

class CityModel {
  String maTinh;

  String tenTinh;

  CityModel({required this.maTinh, required this.tenTinh});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(maTinh: json['maTinh'], tenTinh: json['tenTinh']);
  }

  Map<String, dynamic> toJson() => {
        "maTinh": maTinh,
        "tenTinh": tenTinh,
      };

  static List<CityModel> getListFromJson(List<dynamic> jsonArray) {
    List<CityModel> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(CityModel.fromJson(jsonArray[i]));
    }
    return list;
  }
}
