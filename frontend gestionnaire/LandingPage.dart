import 'package:flutter/material.dart';

import 'AdminHomePage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupère la taille de l'écran
    final size = MediaQuery.of(context).size;
    final double logoSize = size.width * 0.25; // Logo prend 25% de la largeur de l'écran
    final double maxLogoSize = 500; // Taille maximale pour le logo
    final double finalLogoSize = logoSize > maxLogoSize ? maxLogoSize : logoSize;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo responsive
            Container(
              width: finalLogoSize,
              height: finalLogoSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/Images/Logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Progress indicator
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF37C7E1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
