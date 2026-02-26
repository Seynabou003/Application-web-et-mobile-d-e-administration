import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget nextButton(BuildContext context, Widget page) {
  final size = MediaQuery.of(context).size;
  final bool isMobile = size.width < 600;

  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : size.width * 0.2, vertical: 16),
    child: SizedBox(
      width: double.infinity,
      height: isMobile ? 50 : 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFF37C7E1),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : 20,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Text(
          "Suivant",
          style: TextStyle(fontSize: isMobile ? 16 : 20),
        ),
      ),
    ),
  );
}
