import 'package:get/get.dart';
import 'package:quiz_test/data/model/quizdata.dart';
import 'package:quiz_test/data/networkcaller.dart';
import 'package:quiz_test/data/networkresponse.dart';
import '../../data/urls.dart';

class QuizController extends GetxController{
  bool _getQuizinProgress = false;

  Quizmodel _allQuizData = Quizmodel();

  String _errorMessage = '';

  Quizmodel get allQuizData => _allQuizData;


  bool get getQuizinProgress => _getQuizinProgress;

  String get errorMessage => _errorMessage;


  Future<bool> getQuiztest()async{
    _getQuizinProgress = true;
    update();
    final Networkresponse response = await Networkcall().postRequest(Urls.quizz, {});
    _getQuizinProgress = false;
    if(response.issuccess){
      _allQuizData = Quizmodel.fromJson(response.responseJson!);
      print(response.responseJson);
      update();
      return true;
    }else{
      _errorMessage='Fetch data Failed';
      update();
      return false;
    }

  }

}