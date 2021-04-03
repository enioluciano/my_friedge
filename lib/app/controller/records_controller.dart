import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:minhageladeira/app/repository/repository.dart';

class RecordController extends GetxController {
  RxList listItensAll = [].obs;
  List get getListItensAll => listItensAll;
  setListItensAll(item) => listItensAll.add(item);

  final select = "Todos".obs;
  get getSelect => select.value;
  setSelect(newValue) => select.value = newValue;

  getListItemFilterConsumer() async {
    listItensAll.value = await Repository.getListItemFilterBd();
  }

  getListItemFilterAdd() async {
    listItensAll.value = await Repository.getListItemAddFilterBd();
  }

  getlistItemRecent() async {
    listItensAll.value = await Repository.getListItemMoreRecent();
  }
}
