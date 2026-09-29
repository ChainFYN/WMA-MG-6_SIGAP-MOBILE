import 'package:flutter/material.dart';

class StepProgress extends StatelessWidget {
  final int currentStep; // 1, 2, or 3

  const StepProgress({
    super.key,
    this.currentStep = 1,
  });

  Widget _stepItem(String number, String title, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: active ? const Color(0xFF1E88E5) : Colors.grey.shade300,
          child: Text(
            number,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: active ? const Color(0xFF1E88E5) : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _stepItem('1', 'Daftar', currentStep >= 1),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep > 1 ? const Color(0xFF1E88E5) : Colors.grey.shade300,
          ),
        ),
        _stepItem('2', 'Verifikasi', currentStep >= 2),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep > 2 ? const Color(0xFF1E88E5) : Colors.grey.shade300,
          ),
        ),
        _stepItem('3', 'Selesai', currentStep >= 3),
      ],
    );
  }
}
