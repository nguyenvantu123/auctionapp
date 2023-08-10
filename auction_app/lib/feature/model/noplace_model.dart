class NoPlaceModel {
  String bienSo;

  int id;

  String maLoai;

  String maTinh;

  String so;

  String tenLoai;

  String tenTinh;

  NoPlaceModel({
    required this.bienSo,
    required this.id,
    required this.maLoai,
    required this.maTinh,
    required this.so,
    required this.tenLoai,
    required this.tenTinh,
  });

  factory NoPlaceModel.fromJson(Map<String, dynamic> json) {
    return NoPlaceModel(
        bienSo: json['bienSo'],
        id: json['id'],
        maLoai: json['maLoai'],
        maTinh: json['maTinh'],
        so: json['so'],
        tenLoai: json['tenLoai'],
        tenTinh: json['tenTinh']);
  }

  Map<String, dynamic> toJson() => {
        "bienSo": bienSo,
        "id": id,
        "maLoai": maLoai,
        "maTinh": maTinh,
        "so": so,
        "tenLoai": tenLoai,
        "tenTinh": tenTinh,
      };
}
