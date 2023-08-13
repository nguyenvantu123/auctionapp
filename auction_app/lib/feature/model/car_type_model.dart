import 'dart:convert';

import 'package:flutter/services.dart';

class CarTypeModel {
  String maLoai;

  String tenLoai;

  CarTypeModel({required this.maLoai, required this.tenLoai});

  factory CarTypeModel.fromJson(Map<String, dynamic> json) {
    return CarTypeModel(maLoai: json['maLoai'], tenLoai: json['tenLoai']);
  }

  Map<String, dynamic> toJson() => {
        "maLoai": maLoai,
        "tenLoai": tenLoai,
      };

  static List<CarTypeModel> getListFromJson(List<dynamic> jsonArray) {
    List<CarTypeModel> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(CarTypeModel.fromJson(jsonArray[i]));
    }
    return list;
  }
}
