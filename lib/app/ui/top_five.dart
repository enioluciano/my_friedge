import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minhageladeira/app/controller/top_five_controller.dart';
import 'package:minhageladeira/app/models/itens.dart';
import 'package:minhageladeira/util/preferences.dart';

import 'widgets/drawer_custom.dart';

class TopFive extends StatelessWidget {
  final TopFiveController controller = Get.put(TopFiveController());
  @override
  Widget build(BuildContext context) {
    controller.getListTopFive();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top 5 itens mais consumidos",
          style: TextStyle(fontSize: 16),
        ),
      ),
      drawer: DrawerCusom(),
      body: Container(
        margin: EdgeInsets.all(16),
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
                      horizontalTitleGap: 0,
                      title: Text(item.name),
                      // subtitle: Text(item.itemConsumerHistoric.toString()),
                      trailing: Text(
                        item.itemConsumerHistoric.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      leading: Container(
                        height: double.infinity,
                        child: index == 0
                            ? Icon(
                                Icons.star,
                                color: Colors.yellowAccent[700],
                              )
                            : index == 1
                                ? Icon(
                                    Icons.star_half,
                                    color: Colors.yellowAccent[700],
                                  )
                                : index == 2
                                    ? Icon(
                                        Icons.star_border,
                                        color: Colors.yellow[600],
                                      )
                                    : index == 3
                                        ? Icon(
                                            Icons.star_border,
                                            color: Colors.yellow[500],
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.yellow[500],
                                          ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
