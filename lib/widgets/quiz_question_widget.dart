import 'package:flutter/material.dart';

class QuizQuestionWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final int currentIndex;
  final int totalQuestions;
  final Function(int) onAnswer;

  const QuizQuestionWidget({
    Key? key,
    required this.question,
    required this.currentIndex,
    required this.totalQuestions,
    required this.onAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: (currentIndex + 1) / totalQuestions,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          const SizedBox(height: 20),

          // Question Number
          Text(
            'Question ${currentIndex + 1} of $totalQuestions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Question Text
          Card(
            elevation: 4,
            shadowColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                question['question'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Options
          ...question['options'].map<Widget>((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => onAnswer(option['score']),
                child: Text(
                  option['text'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
