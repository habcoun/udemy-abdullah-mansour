class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel({this.status, this.message, this.data});

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new UserData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  UserData(
      {this.name, this.email, this.phone, this.id, this.image, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
