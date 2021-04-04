import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  int count;
  int itemConsumer;
  int itemAvailable;
  String search;
  bool consumer;
  bool ifExistAdd;
  String data;
  int milliSeconds;
  int itemConsumerHistoric;

  Item(
      {this.id,
      this.name,
      this.count,
      this.data,
      this.itemConsumerHistoric,
      this.milliSeconds,
      this.itemAvailable,
      this.itemConsumer,
      this.consumer,
      this.ifExistAdd,
      this.search});

  Item.gerarIdPublicador() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference item = db.collection("itens");
    this.id = item.doc().id;
  }

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    milliSeconds = json['milliSeconds'];
    data = json['data'];
    ifExistAdd = json['ifExistAdd'];
    consumer = json['consumer'];
    count = json['count'];
    itemAvailable = json['itemAvailable'];
    itemConsumer = json['itemConsumer'];
    itemConsumerHistoric = json['itemConsumerHistoric'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['data'] = this.data;
    data['milliSeconds'] = this.milliSeconds;
    data['ifExistAdd'] = this.ifExistAdd;
    data['consumer'] = this.consumer;
    data['itemAvailable'] = this.itemAvailable;
    data['itemConsumer'] = this.itemConsumer;
    data['itemConsumerHistoric'] = this.itemConsumerHistoric;
    data['search'] = this.name.toLowerCase();
    return data;
  }
}
