import 'package:flutter/material.dart';

class PageCollaborateur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nos collaborateurs"),
        backgroundColor: Color(0xFF19BDAB),
      ),
      body: Center(
        child: Text(
          "Nos partenaires et collaborateurs",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
