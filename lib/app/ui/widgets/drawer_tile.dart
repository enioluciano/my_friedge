import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;

  final String text;

  final PageController controller;
  final int page;

  DrawerTile({
    this.icon,
    this.text,
    this.page,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Get.to(Construtora());
          controller.jumpToPage(page);
          Get.back();

          if (page != 4) {
            Get.back();
            controller.jumpToPage(page);
          } else {
            // Get.offAll(HomeScreen());
          }
        },
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Icon(icon,
                    size: 25,
                    color: controller.page.round() == page
                        ? Colors.blue
                        : Colors.grey[500]),
                SizedBox(
                  width: 16,
                ),
                Text(
                  this.text,
                  style: TextStyle(
                      color: controller.page.round() == page
                          ? Colors.blue
                          : Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
