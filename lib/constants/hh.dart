class All{

  String? data;
  Items? items;
  All({this.data,this.items});

  Map<String,dynamic> fromJson(){
    return{
      "data":data,
      "items":items
    };
  }
}
class Items{

  int? age;
  int? phone;
  Items({this.age,this.phone});

}