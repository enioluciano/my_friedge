import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minhageladeira/app/controller/home_controller.dart';
import 'package:minhageladeira/app/ui/my_fridge.dart';
import 'package:minhageladeira/app/ui/records.dart';
import 'package:minhageladeira/app/ui/top_five.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      children: [MyFridge(), Record(), TopFive()],
    );
  }
}
