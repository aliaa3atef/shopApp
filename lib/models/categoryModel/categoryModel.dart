class CategoryModel
{
  bool status ;
  CatDataModel dataModel;

  CategoryModel.fromJson(Map<String,dynamic> json)
  {
    dataModel = CatDataModel.fromJson(json['data']);
  }
}

class CatDataModel
{
  List<Data> data = [];

  CatDataModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(Data.fomJson(element));
    });
  }
}

class Data
{
  int id;
  String name , image;

  Data.fomJson(Map <String, dynamic> json )
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}