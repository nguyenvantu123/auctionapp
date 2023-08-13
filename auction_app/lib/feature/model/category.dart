import 'package:auction_app/feature/model/car_type_model.dart';
import 'package:auction_app/feature/model/city_model.dart';

class CategoryModel {
  List<CarTypeModel> loaiXe;

  List<CityModel> tinhThanh;

  CategoryModel({required this.loaiXe, required this.tinhThanh});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        loaiXe: CarTypeModel.getListFromJson(json['loaiXe']),
        tinhThanh: CityModel.getListFromJson(json['tinhThanh']));
  }

  Map<String, dynamic> toJson() => {
        "loaiXe": loaiXe,
        "tinhThanh": tinhThanh,
      };
}
