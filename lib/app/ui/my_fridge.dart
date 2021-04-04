import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minhageladeira/app/controller/my_fridge_controller.dart';
import 'package:minhageladeira/app/models/itens.dart';

import 'package:minhageladeira/app/ui/widgets/drawer_custom.dart';
import 'package:minhageladeira/util/preferences.dart';

class MyFridge extends StatelessWidget {
  final MyFridgeController controller = MyFridgeController();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    controller.getItensBd();
    return Scaffold(
        appBar: AppBar(
          title: Text("Minha geladeira"),
          centerTitle: true,
        ),
        drawer: DrawerCusom(),
        body: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.all(16),
            child: Obx(() => controller.getListItens.isEmpty
                ? Center(
                    child: Text(
                      "Nenhum item na geladeira",
                      style: TextStyle(
                          color: corCinza,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.getListItens.length,
                    itemBuilder: (contex, index) {
                      Itens item = controller.getListItens[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        shadowColor: corCinza,
                        child: ListTile(
                          visualDensity: VisualDensity.comfortable,
                          horizontalTitleGap: 0,
                          minVerticalPadding: 0,
                          title: Text(item.name),
                          subtitle: item.itemAvailable < 2
                              ? Text(
                                  "É necessário repor os alimentos!",
                                  style: TextStyle(fontSize: 12),
                                )
                              : null,
                          leading: item.itemAvailable >= 4
                              ? Icon(
                                  Icons.arrow_circle_up_outlined,
                                  color: Colors.green,
                                )
                              : item.itemAvailable >= 2 &&
                                      item.itemAvailable < 4
                                  ? Icon(Icons.arrow_circle_up_outlined,
                                      color: Colors.yellow)
                                  : Container(
                                      height: double.infinity,
                                      child: Icon(
                                        Icons.arrow_circle_up_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                          trailing: Text(
                            item.itemAvailable.toString(),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          onTap: () => showDialogConsumeItem(item),
                        ),
                      );
                    })),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogAddItem();
          },
          child: Icon(Icons.add),
        ));
  }

  showDialogAddItem() {
    Get.defaultDialog(
        title: "Adicionar item na geladeira",
        titleStyle: TextStyle(fontSize: 17),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Column(children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Nome do item",
              ),
              onChanged: (String name) {
                controller.getItem.name = name;
                controller.getItem.search = name.toLowerCase();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    if (controller.getItem.itemAvailable > 0) {
                      setState(() => controller.item.value.itemAvailable--);
                    }
                  },
                  child: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                Text("${controller.getItem.itemAvailable}"),
                TextButton(
                  onPressed: () {
                    setState(() => controller.item.value.itemAvailable++);
                  },
                  child: Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ]);
        }),
        barrierDismissible: false,
        textConfirm: "Adicionar",
        buttonColor: Colors.white,
        confirmTextColor: Colors.green,
        textCancel: "Cancelar",
        cancelTextColor: Colors.red,
        onConfirm: () {
          controller.getItem.count = controller.getItem.itemAvailable;

          controller.loadingData();
        },
        onCancel: () => Get.back());
  }

  showDialogConsumeItem(Itens item) {
    return Get.defaultDialog(
        title: "Item para consumir",
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quantidade disponível: ",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Text("${item.itemAvailable}"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      if (controller.getContador <= 0) {
                        return null;
                      } else {
                        // setState(() => item.itemConsumer--);
                        setState(() => controller.contador.value--);
                        print(
                            "contador retirar = ${controller.contador.value}");

                        print(item.itemConsumer);
                        // item.count
                      }
                    },
                    child: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                  Text("${controller.getContador}"),
                  TextButton(
                    onPressed: () {
                      if (controller.getContador >= item.itemAvailable) {
                        return null;
                      } else {
                        // setState(() => item.itemConsumer++);
                        setState(() => controller.contador.value++);
                        print("contador add = ${controller.contador.value}");
                      }
                    },
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        textConfirm: "Consumir",
        buttonColor: Colors.white,
        confirmTextColor: Colors.green,
        textCancel: "Cancelar",
        cancelTextColor: Colors.red,
        onConfirm: () {
          if (controller.getContador > 0) {
            item.itemAvailable = item.itemAvailable - controller.getContador;
            item.itemConsumerHistoric =
                item.itemConsumerHistoric + controller.getContador;

            controller.updateDataFridge(item);
          } else {
            Get.rawSnackbar(
                backgroundColor: Colors.red,
                messageText: Text(
                  "Digite um valor maior que zero!",
                  style: TextStyle(color: corBranca),
                ),
                icon: Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.white,
                ));
          }
        },
        onCancel: () => Get.back());
  }
}
