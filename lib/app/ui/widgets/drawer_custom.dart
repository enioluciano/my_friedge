import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minhageladeira/app/controller/home_controller.dart';

import 'drawer_tile.dart';

class DrawerCusom extends StatelessWidget {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget build() => Container(
          decoration: BoxDecoration(color: Colors.white),
        );
    return Drawer(
      child: Stack(
        children: [
          build(),
          ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 12),
                        child: Column(
                          children: [
                            Text(
                              "Minha geladeira",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "email@email.com.br",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
                thickness: 0.2,
                height: 3,
              ),
              Column(
                children: [
                  DrawerTile(
                    icon: Icons.calendar_view_day_sharp,
                    text: 'Minha geladeira',
                    controller: homeController.pageController,
                    page: 0,
                  ),
                  Divider(),
                  DrawerTile(
                    icon: Icons.history,
                    text: "Histórico",
                    controller: homeController.pageController,
                    page: 1,
                  ),
                  Divider(),
                  DrawerTile(
                    icon: Icons.star,
                    text: "Top 5 mais consumidos",
                    controller: homeController.pageController,
                    page: 2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
