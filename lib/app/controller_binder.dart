import 'package:get/get.dart';
import 'package:quiz_test/statemanager/quizController.dart';
class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(QuizController());
  }
}