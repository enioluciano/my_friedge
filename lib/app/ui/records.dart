import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minhageladeira/app/controller/records_controller.dart';
import 'package:minhageladeira/app/models/itens.dart';
import 'package:minhageladeira/util/format_data.dart';
import 'package:minhageladeira/util/preferences.dart';

import 'widgets/drawer_custom.dart';

class Record extends StatelessWidget {
  final RecordController controller = Get.put(RecordController());
  @override
  Widget build(BuildContext context) {
    controller.setSelect("Todos");
    controller.getlistItemRecent();

    return Scaffold(
      backgroundColor: corBranca,
      appBar: AppBar(
        title: Text(
          "Histórico de Registro",
          style: TextStyle(fontSize: 16),
        ),
      ),
      drawer: DrawerCusom(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Categoria: ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Obx(() => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                          hint: Text("Selecione"),
                          value: controller.getSelect,
                          onChanged: (newValue) {
                            controller.setSelect(newValue);
                            controller.getSelect == "Todos"
                                ? controller.getlistItemRecent()
                                : controller.getSelect == "Adicionados"
                                    ? controller.getListItemFilterAdd()
                                    : controller.getListItemFilterConsumer();
                          },
                          items: <String>[
                            "Todos",
                            "Consumidos",
                            "Adicionados",
                          ]
                              .map((String select) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        select == "Adicionados"
                                            ? Icon(
                                                Icons.add_circle,
                                                color: Colors.green[700],
                                                size: 20,
                                              )
                                            : select == "Consumidos"
                                                ? Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 20,
                                                  )
                                                : Icon(
                                                    Icons.list_rounded,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(select),
                                      ],
                                    ),
                                    value: select,
                                  ))
                              .toList()),
                    )),
                SizedBox(
                  width: 3,
                ),
              ],
            ),
            Expanded(
                child: Obx(() => controller.getListItensAll.isEmpty
                    ? Center(
                        child: Text(
                          "Sem histórico!",
                          style: TextStyle(
                              color: corCinza,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.getListItensAll.length,
                        itemBuilder: (context, index) {
                          Item item = controller.getListItensAll[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            shadowColor: corCinza,
                            child: ListTile(
                                title: Text(item.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  "${FormatDataCustom.formatData(item.data)} - ${FormatDataCustom.formatHour(item.data)}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing: item.consumer == true
                                    ? Text(
                                        "- ${item.itemConsumer.toString()}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : item.ifExistAdd == true
                                        ? Text(
                                            item.count.toString(),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Text(
                                            item.itemAvailable.toString(),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w400),
                                          )),
                          );
                        })))
          ],
        ),
      ),
    );
  }
}
