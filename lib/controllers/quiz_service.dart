import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/quiz_model.dart';

class QuizService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';
  Future<QuizModel> fetchQuizData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return QuizModel.fromJson(data);
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (error) {
      throw Exception('Failed to load quiz data: $error');
    }
  }

  static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Something went wrong. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
