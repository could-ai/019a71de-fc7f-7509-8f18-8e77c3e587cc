import 'package:flutter/material.dart';
import 'addition_exercise_screen.dart';

class AdditionLessonScreen extends StatelessWidget {
  const AdditionLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Materi Penjumlahan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Introduction Card
              _buildInfoCard(
                icon: Icons.school,
                title: 'Apa itu Penjumlahan?',
                description:
                    'Penjumlahan adalah menggabungkan dua kelompok benda atau angka menjadi satu kelompok yang lebih besar.',
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
              // Example 1
              _buildExampleCard(
                title: 'Contoh 1: Penjumlahan dengan Gambar',
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAppleGroup(2),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildAppleGroup(3),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '=',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildAppleGroup(5),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '2 + 3 = 5',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Dua apel ditambah tiga apel sama dengan lima apel!',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Example 2
              _buildExampleCard(
                title: 'Contoh 2: Penjumlahan dengan Angka',
                content: Column(
                  children: [
                    _buildNumberExample('1', '+', '1', '=', '2'),
                    const SizedBox(height: 15),
                    _buildNumberExample('3', '+', '2', '=', '5'),
                    const SizedBox(height: 15),
                    _buildNumberExample('4', '+', '1', '=', '5'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tips Card
              _buildInfoCard(
                icon: Icons.lightbulb,
                title: 'Tips Belajar',
                description:
                    'Gunakan jari tanganmu untuk menghitung! Angkat jari sesuai angka pertama, lalu tambahkan dengan angka kedua.',
                color: Colors.amber,
              ),
              const SizedBox(height: 30),
              // Exercise Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdditionExerciseScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'Mulai Latihan Soal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade300, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildAppleGroup(int count) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(
        count,
        (index) => const Icon(
          Icons.circle,
          size: 30,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildNumberExample(
    String num1,
    String operator,
    String num2,
    String equals,
    String result,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberBox(num1, Colors.blue),
        _buildOperatorText(operator),
        _buildNumberBox(num2, Colors.blue),
        _buildOperatorText(equals),
        _buildNumberBox(result, Colors.green),
      ],
    );
  }

  Widget _buildNumberBox(String number, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorText(String operator) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        operator,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}