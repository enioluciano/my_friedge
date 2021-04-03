import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhageladeira/app/models/itens.dart';

class Repository {
  static Future<int> createDataBd(Itens item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference itemId = db.collection("itens");
    item.id = itemId.doc().id;
    int statusCode;
    try {
      statusCode = await db
          .collection("itens")
          .doc(item.id)
          .set(item.toJson())
          .then((value) => 200);

      createHistoryItemRegisterDb(item);

      return statusCode;
    } catch (e) {
      statusCode = 400;
      return statusCode;
    }
  }

  static Future<int> createHistoryItemRegisterDb(Itens item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference i = db.collection("historico");
    item.id = i.doc().id;
    int statusCode;
    try {
      statusCode = await db
          .collection("historico")
          .doc(item.id)
          .set(item.toJson())
          .then((value) => 200);

      return statusCode;
    } catch (e) {
      statusCode = 400;
      return statusCode;
    }
  }

  static Future<int> createHistoryItemConsumerDb(Itens item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference i = db.collection("historico");
    item.id = i.doc().id;
    item.consumer = true;
    int statusCode;
    try {
      statusCode = await db
          .collection("historico")
          .doc(item.id)
          .set(item.toJson())
          .then((value) => 200);

      return statusCode;
    } catch (e) {
      statusCode = 400;
      return statusCode;
    }
  }

  static Future<List<Itens>> getListItemFilterBd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("historico")
        .where("consumer", isEqualTo: true)
        .orderBy("milliSeconds", descending: true)
        .get();
    List<Itens> listItemConsumer = [];
    for (var item in querySnapshot.docs) {
      Itens i = Itens.fromJson(item.data());
      listItemConsumer.add(i);
    }
    return listItemConsumer;
  }

  static Future<List<Itens>> getListItemAddFilterBd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("historico")
        .where("consumer", isEqualTo: false)
        .orderBy("milliSeconds", descending: true)
        .get();
    List<Itens> listItemConsumer = [];
    for (var item in querySnapshot.docs) {
      Itens i = Itens.fromJson(item.data());
      listItemConsumer.add(i);
    }
    return listItemConsumer;
  }

  static Future<List<Itens>> getListItemMoreRecent() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("historico")
        .orderBy("milliSeconds", descending: true)
        .get();
    List<Itens> listItemMoreRecent = [];
    for (var item in querySnapshot.docs) {
      Itens i = Itens.fromJson(item.data());

      listItemMoreRecent.add(i);
    }

    return listItemMoreRecent;
  }

  static Future<List<Itens>> getListItemLessRecent() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("historico")
        .orderBy("milliSeconds", descending: false)
        .get();
    List<Itens> listItemLessRecent = [];
    for (var item in querySnapshot.docs) {
      Itens i = Itens.fromJson(item.data());

      listItemLessRecent.add(i);
    }

    return listItemLessRecent;
  }

  static Future<List<Itens>> getListTopFiveBd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("itens")
        .orderBy("itemConsumerHistoric", descending: true)
        .get();
    List<Itens> list = [];
    for (var item in querySnapshot.docs) {
      Itens i = Itens.fromJson(item.data());
      if (i.itemConsumerHistoric > 0) {
        list.add(i);
      }
    }

    return list;
  }

  getItensBd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("itens").snapshots().listen((QuerySnapshot querySnapshot) {
      List<Itens> listItem = querySnapshot.docs
          .map((QueryDocumentSnapshot queryDocumentSnapshot) =>
              Itens.fromJson(queryDocumentSnapshot.data()))
          .toList();

      return listItem;
    });
  }

  //
  static Future<int> updateDataBd(Itens item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int statusCode;

    try {
      statusCode = await db
          .collection("itens")
          .doc(item.id)
          .update(item.toJson())
          .then((value) => 200);

      createHistoryItemConsumerDb(item);

      return statusCode;
    } catch (e) {
      statusCode = 400;
      return statusCode;
    }
  }

  static Future<int> updateDataFruitIfExistBd(Itens item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int statusCode;

    try {
      statusCode = await db
          .collection("itens")
          .doc(item.id)
          .update(item.toJson())
          .then((value) async {
        await db.collection("historico").doc(item.id).set(item.toJson());
        return 200;
      });
      // createHistoryItemConsumerDb(item);

      return statusCode;
    } catch (e) {
      statusCode = 400;
      return statusCode;
    }
  }

  static Future<int> verifyInBdIfFruitExist(Itens currentitem) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection("itens").get();
    int statusCode;
    bool exist = false;

    for (var p in querySnapshot.docs) {
      Itens i = Itens.fromJson(p.data());
      if (i.search == currentitem.search) {
        Itens itemExist = Itens.fromJson(p.data());
        itemExist.count = currentitem.count;
        itemExist.ifExistAdd = true;
        itemExist.data = currentitem.data;
        itemExist.milliSeconds = currentitem.milliSeconds;
        itemExist.itemAvailable =
            itemExist.itemAvailable + currentitem.itemAvailable;
        statusCode = await updateDataFruitIfExistBd(itemExist);
        exist = true;
      }
    }
    if (exist == false) {
      statusCode = await createDataBd(currentitem);
    }
    return statusCode;
  }
}
