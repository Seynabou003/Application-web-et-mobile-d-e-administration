import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep; // étape actuelle (0 à totalSteps-1)
  final int totalSteps;

  const StepProgressBar({
    Key? key,
    required this.currentStep,
    this.totalSteps = 5, // nombre total d'étapes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    final double circleSize = isMobile ? 12 : 16;
    final double activeCircleSize = isMobile ? 16 : 20;
    final double spacing = isMobile ? 4 : 8;
    final double fontSize = isMobile ? 12 : 16;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSteps, (index) {
            bool isActive = index <= currentStep;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: spacing),
              width: isActive ? activeCircleSize : circleSize,
              height: isActive ? activeCircleSize : circleSize,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF37C7E1) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        SizedBox(height: spacing),
        Text(
          "Étape ${currentStep + 1}/$totalSteps",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
