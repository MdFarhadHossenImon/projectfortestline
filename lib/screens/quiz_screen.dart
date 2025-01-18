import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../controllers/quiz_service.dart';
import '../widgets/quiz_question_widget.dart';
import '../widgets/quiz_result_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizModel? _quizModel;
  int _currentIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
  }

  Future<void> _fetchQuizData() async {
    try {
      final quizData = await QuizService().fetchQuizData(); // Corrected here
      setState(() {
        _quizModel = quizData;
      });
    } catch (e) {
      QuizService.showErrorDialog(context);
    }
  }


  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentIndex >= _quizModel!.questions!.length) {
      return QuizResultWidget(
        score: _score,
        onRestart: () => Navigator.pop(context),
      );
    }

    final question = _quizModel!.questions![_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(_quizModel!.title ?? 'Quiz'),
      ),
      body: QuizQuestionWidget(
        question: {
          'question': question.description,
          'options': question.options?.map((opt) => {
            'text': opt.description,
            'score': opt.isCorrect == true ? 1 : 0,
          }).toList(),
        },
        currentIndex: _currentIndex,
        totalQuestions: _quizModel!.questions!.length,
        onAnswer: _answerQuestion,
      ),
    );
  }
}
