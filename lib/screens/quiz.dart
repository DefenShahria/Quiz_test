import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test/screens/QuizContainer.dart';
import 'package:quiz_test/statemanager/quizController.dart';

class Quiztest extends StatefulWidget {
  const Quiztest({super.key});

  @override
  State<Quiztest> createState() => _QuiztestState();
}

class _QuiztestState extends State<Quiztest> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<QuizController>().getQuiztest();
    });
  }

  void _onOptionSelected(String selectedOption) {
    final quizController = Get.find<QuizController>();
    final questionData = quizController.allQuizData.results![_currentQuestionIndex];

    if (selectedOption == questionData.correctAnswer) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < quizController.allQuizData.results!.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    final quizController = Get.find<QuizController>();
    final totalQuestions = quizController.allQuizData.results!.length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Result'),
        content: Text('You scored $_score out of $totalQuestions'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Go back to the previous page (home page)
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Quiz Test'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<QuizController>(
              builder: (quizController) {
                if (quizController.getQuizinProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (quizController.errorMessage.isNotEmpty) {
                  return Center(child: Text(quizController.errorMessage));
                } else if (quizController.allQuizData.results == null ||
                    quizController.allQuizData.results!.isEmpty) {
                  return Center(child: Text('No quiz data available'));
                }
        
                final questionData = quizController.allQuizData.results![_currentQuestionIndex];
                final List<String> options = List.from(questionData.incorrectAnswers!)..add(questionData.correctAnswer!);
                options.shuffle(); // Shuffle options for multiple-choice questions
        
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${quizController.allQuizData.results!.length}',
                      style: Theme.of(context).textTheme.titleMedium, // Updated style
                    ),
                    SizedBox(height: 16.0),
                    QuizContainer(
                      question: questionData.question!,
                      options: options,
                      onOptionSelected: _onOptionSelected,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
