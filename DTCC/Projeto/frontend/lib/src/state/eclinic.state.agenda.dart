import 'package:get/get.dart';

class AgendaController extends GetxController {
  final _num = 0.obs;
  get num => this._num.value;
  set num(value) => this._num.value = value;

  increment() {
    this.num++;
  }
  decrement() {
    this.num--;
  }
}