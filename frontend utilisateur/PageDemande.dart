import 'package:flutter/material.dart';
import 'Etapeformulaire.dart';
import 'PagePrincipal.dart';
import'PageNombreExemplaire.dart';
class PageDemande extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar identique à la page principale
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



      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Choisissez le document à demander",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 30),

            _buildDocumentCard(
              context,
              title: "Extrait de naissance",
              icon: Icons.description,
            ),

            const SizedBox(height: 20),

            _buildDocumentCard(
              context,
              title: "Certificat de résidence",
              icon: Icons.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(
      BuildContext context, {
        required String title,
        required IconData icon,
      }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageNombreExemplaire(
                typeDocument: title,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF37C7E1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: Color(0xFF37C7E1)),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
