import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt option = 0.obs;

  setOption(int newOption) {
    option.value = newOption;
  }
}
