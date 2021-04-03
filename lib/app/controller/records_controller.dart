import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:minhageladeira/app/models/itens.dart';
import 'package:minhageladeira/app/repository/repository.dart';

class RecordController extends GetxController {
  RxList listItensAll = [].obs;
  List get getListItensAll => listItensAll;
  setListItensAll(item) => listItensAll.add(item);

  final select = "Todos".obs;
  get getSelect => select.value;
  setSelect(newValue) => select.value = newValue;

  // final selectMostRecent = "Todos".obs;
  // get getMostRecent => selectMostRecent.value;
  // setMostRecent(newValue) => selectMostRecent.value = newValue;

  // getHistoricItensRegister() async {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   db
  //       .collection("historico")
  //       .orderBy("milliSeconds", descending: true)
  //       .snapshots()
  //       .listen((QuerySnapshot querySnapshot) {
  //     listItensAll.value = querySnapshot.docs
  //         .map((QueryDocumentSnapshot queryDocumentSnapshot) =>
  //             Itens.fromJson(queryDocumentSnapshot.data()))
  //         .toList();
  //   });
  // }

  getListItemFilterConsumer() async {
    listItensAll.value = await Repository.getListItemFilterBd();
  }

  getListItemFilterAdd() async {
    listItensAll.value = await Repository.getListItemAddFilterBd();
  }

  getlistItemRecent() async {
    listItensAll.value = await Repository.getListItemMoreRecent();
  }

  // getlistItemLess() async {
  //   listItensAll.value = await Repository.getListItemLessRecent();
  // }
}
