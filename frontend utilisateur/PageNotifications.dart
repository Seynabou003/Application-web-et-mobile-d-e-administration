import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = [
      "Votre demande d'extrait de naissance a été validée.",
      "Votre paiement Wave a été reçu.",
      "Un nouveau document est disponible pour téléchargement.",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Image.asset(
              'Assets/Images/Logo.png',
              height: 200,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.notifications, color: Color(0xFF37C7E1)),
              title: Text(notifications[index]),
            ),
          );
        },
      ),
    );
  }
}
