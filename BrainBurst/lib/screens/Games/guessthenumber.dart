import 'package:flutter/material.dart';

class MCQGame extends StatefulWidget {
  @override
  _MCQGameState createState() => _MCQGameState();
}

class _MCQGameState extends State<MCQGame> {
  final Map<String, dynamic> _questions = {
    "പൂജ്യം": {
      "options": ["1", "2", "0", "3"],
      "answer": "0"
    },
    "പത്തു": {
      "options": ["10", "11", "12", "13"],
      "answer": "10"
    },
    "പതിനൊന്ന്": {
      "options": ["11", "12", "13", "14"],
      "answer": "11"
    },
    "പന്ത്രണ്ട്": {
      "options": ["12", "13", "14", "15"],
      "answer": "12"
    },
    "പതിമൂന്നു": {
      "options": ["13", "14", "15", "16"],
      "answer": "13"
    },
    "പതിനാറു": {
      "options": ["14", "15", "16", "17"],
      "answer": "16"
    },
    // Add more questions here
  };

  int _currentQuestionIndex = 0;
  int _score = 0;
  List<String> _questionOrder = [];

  @override
  void initState() {
    super.initState();
    _questionOrder = _questions.keys.toList()..shuffle();
  }

  void _handleAnswerSelection(String selectedOption) {
    String currentQuestion = _questionOrder[_currentQuestionIndex];
    String correctAnswer = _questions[currentQuestion]["answer"];
    setState(() {
      _currentQuestionIndex++;
      if (selectedOption == correctAnswer) {
        _score++;
      }
    });
  }

  bool _isLastQuestion() {
    return _currentQuestionIndex == _questionOrder.length - 1;
  }

  void _restartGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _questionOrder.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLastQuestion()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MCQ Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You finished the quiz!',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Your score: $_score out of ${_questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: _restartGame,
                child: const Text('Restart Game'),
              ),
            ],
          ),
        ),
      );
    }

    String currentQuestion = _questionOrder[_currentQuestionIndex];
    Map<String, dynamic> currentQuestionData = _questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MCQ Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              currentQuestion,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            for (String option in currentQuestionData["options"])
              RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _currentQuestionIndex.toString(),
                onChanged: (value) => _handleAnswerSelection(value!),
              ),
          ],
        ),
      ),
    );
  }
}
