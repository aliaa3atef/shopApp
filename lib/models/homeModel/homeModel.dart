class HomeModel {
  bool status;
  DataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<Banners> banners = [];
  List<Products> products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element){
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(Products.fromJson(element));
    });
  }
}

class Banners {
  int id;
  String image;
  dynamic category , product;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];

  }
}

class Products {
  int id;
  dynamic price, oldPrice, discount;
  String image, name, description;
  bool inFavourites, inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
