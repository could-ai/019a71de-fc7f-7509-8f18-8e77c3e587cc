import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:math';

class AdditionExerciseScreen extends StatefulWidget {
  const AdditionExerciseScreen({super.key});

  @override
  State<AdditionExerciseScreen> createState() => _AdditionExerciseScreenState();
}

class _AdditionExerciseScreenState extends State<AdditionExerciseScreen> {
  int currentQuestion = 0;
  int score = 0;
  List<Map<String, dynamic>> questions = [];
  String? selectedAnswer;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    final random = Random();
    questions = List.generate(10, (index) {
      int num1 = random.nextInt(5) + 1; // 1-5
      int num2 = random.nextInt(5) + 1; // 1-5
      int correctAnswer = num1 + num2;
      
      // Generate wrong answers
      Set<int> options = {correctAnswer};
      while (options.length < 4) {
        int wrongAnswer = random.nextInt(10) + 1;
        if (wrongAnswer != correctAnswer && wrongAnswer <= 10) {
          options.add(wrongAnswer);
        }
      }
      
      List<int> shuffledOptions = options.toList()..shuffle();
      
      return {
        'num1': num1,
        'num2': num2,
        'correctAnswer': correctAnswer,
        'options': shuffledOptions,
      };
    });
  }

  void _checkAnswer(String answer) {
    if (isAnswered) return;
    
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
      
      if (int.parse(answer) == questions[currentQuestion]['correctAnswer']) {
        score++;
      }
    });

    // Wait 2 seconds before moving to next question
    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          selectedAnswer = null;
          isAnswered = false;
        });
      } else {
        // Navigate to result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: score,
              totalQuestions: questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestion];
    final num1 = question['num1'];
    final num2 = question['num2'];
    final correctAnswer = question['correctAnswer'];
    final options = question['options'] as List<int>;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(
          'Soal ${currentQuestion + 1} dari ${questions.length}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 30),
              // Score Display
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildScoreItem(Icons.star, 'Skor', score.toString()),
                    _buildScoreItem(
                      Icons.quiz,
                      'Soal',
                      '${currentQuestion + 1}/${questions.length}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Question Card
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Berapa hasilnya?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Visual representation with circles
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCircleGroup(num1, Colors.blue),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildCircleGroup(num2, Colors.orange),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // Question
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNumberDisplay(num1.toString(), Colors.blue),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildNumberDisplay(num2.toString(), Colors.orange),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '=',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildNumberDisplay('?', Colors.purple),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Answer Options
                    const Text(
                      'Pilih Jawabanmu:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: options.map((option) {
                        return _buildAnswerButton(
                          option.toString(),
                          option == correctAnswer,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange.shade600, size: 28),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleGroup(int count, Color color) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(
        count,
        (index) => Icon(
          Icons.circle,
          size: 25,
          color: color,
        ),
      ),
    );
  }

  Widget _buildNumberDisplay(String number, Color color) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(String answer, bool isCorrect) {
    Color buttonColor;
    if (!isAnswered) {
      buttonColor = Colors.blue.shade600;
    } else if (selectedAnswer == answer) {
      buttonColor = isCorrect ? Colors.green.shade600 : Colors.red.shade600;
    } else if (isCorrect) {
      buttonColor = Colors.green.shade600;
    } else {
      buttonColor = Colors.grey.shade400;
    }

    return InkWell(
      onTap: () => _checkAnswer(answer),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}