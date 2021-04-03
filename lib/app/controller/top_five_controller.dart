import 'package:get/get.dart';
import 'package:minhageladeira/app/repository/repository.dart';

class TopFiveController extends GetxController {
  RxList listItensAll = [].obs;
  List get getListItensAll => listItensAll;
  setListItensAll(item) => listItensAll.add(item);

  getListTopFive() async {
    listItensAll.value = await Repository.getListTopFiveBd();
    if (listItensAll.length >= 5) {
      listItensAll.value = listItensAll.sublist(0, 5);
    }
  }
}
