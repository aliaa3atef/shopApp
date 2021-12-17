class FavouritesModel
{
  bool status;
  Data data;

  FavouritesModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data
{
  List<FavData> data = [];

  Data.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(FavData.fromJson(element));
    });
  }
}

class FavData
{
  int id;
  Products products;

  FavData.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    products = Products.fromJson(json['product']);
  }
}

class Products
{
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}