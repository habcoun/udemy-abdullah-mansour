class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel({
    this.status,
    this.data,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data = [];
  CategoriesDataModel({
    this.currentPage,
    this.data,
  });
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach(
        (v) {
          data!.add(DataModel.fromJson(v));
        },
      );
    }
  }
}

class DataModel {
  int? id;
  String? nameCategorie;
  String? imageCategorie;
  DataModel({
    this.id,
    this.nameCategorie,
    this.imageCategorie,
  });
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCategorie = json['name'];
    imageCategorie = json['image'];
  }
}
