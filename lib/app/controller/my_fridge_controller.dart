import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:minhageladeira/app/models/itens.dart';
import 'package:minhageladeira/app/repository/repository.dart';

class MyFridgeController extends GetxController {
  RxList listItens = [].obs;
  List get getListItens => listItens;
  setListItens(item) => listItens.add(item);

  Rx<Itens> item = Itens(
          count: 0,
          itemAvailable: 0,
          itemConsumer: 0,
          itemConsumerHistoric: 0,
          consumer: false,
          ifExistAdd: false)
      .obs;
  Itens get getItem => item.value;
  setItem(newItem) => item.value = newItem;

  loadingData() {
    Get.defaultDialog(
        barrierDismissible: false,
        radius: 5,
        title: "",
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 20, height: 20, child: CircularProgressIndicator()),
            SizedBox(
              width: 10,
            ),
            Text(
              "Salvando...",
              style: TextStyle(fontSize: 13),
            )
          ],
        ));
    Future.delayed(Duration(seconds: 2), () {
      verifyIfFruitExist();
    });
  }

  // createItem() async {
  //   int status = await Repository.createDataBd(getItem);
  //   if (status == 200) {
  //     Get.back();
  //     Get.defaultDialog(
  //         title: "",
  //         content: Center(
  //           child: Column(
  //             children: [
  //               Icon(
  //                 Icons.check_circle,
  //                 size: 45,
  //                 color: Colors.green[600],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Text(
  //                 "Item salvo com sucesso!",
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         ));
  //     Future.delayed(Duration(seconds: 2), () {
  //       Get.back();
  //       Get.back();
  //     });
  //   } else {
  //     Get.defaultDialog(
  //         title: "Alerta!",
  //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
  //         barrierDismissible: true,
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               Icons.error,
  //               color: Colors.red,
  //             ),
  //             Text(" Erro ao salvar os dados.")
  //           ],
  //         ));
  //   }
  // }

  getItensBd() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("itens").snapshots().listen((QuerySnapshot querySnapshot) {
      listItens.value = querySnapshot.docs
          .map((QueryDocumentSnapshot queryDocumentSnapshot) =>
              Itens.fromJson(queryDocumentSnapshot.data()))
          .toList();
    });
  }

  updateDataFridge(Itens item) async {
    item.data = DateTime.now().toString();

    item.milliSeconds = DateTime.now().millisecondsSinceEpoch;
    int status = await Repository.updateDataBd(item);
    if (status == 200) {
      item.itemConsumer = 0;
      Get.back();
      Get.defaultDialog(
          title: "",
          content: Center(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 45,
                  color: Colors.green[600],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Item consumido com sucesso!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ));
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        Get.back();
      });
    } else {
      Get.defaultDialog(
          title: "Alerta!",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          barrierDismissible: true,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(" Erro ao consumir o item.")
            ],
          ));
    }
  }

  verifyIfFruitExist() async {
    print(getItem.count);
    item.value.data = DateTime.now().toString();

    item.value.milliSeconds = DateTime.now().millisecondsSinceEpoch;
    int status = await Repository.verifyInBdIfFruitExist(getItem);
    if (status == 200) {
      item.value.count = 0;
      item.value.itemAvailable = 0;
      // Get.create<MyFridgeController>(() => MyFridgeController());
      Get.back();
      Get.defaultDialog(
          title: "",
          content: Center(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 45,
                  color: Colors.green[600],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Item salvo com sucesso!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ));
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        Get.back();
      });
    } else {
      Get.defaultDialog(
          title: "Alerta!",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          barrierDismissible: true,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(" Erro ao salvar os dados.")
            ],
          ));
    }
  }
}
