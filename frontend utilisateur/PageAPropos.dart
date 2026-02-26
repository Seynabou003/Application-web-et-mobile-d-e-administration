import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAPropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "À propos d'AdminXpress",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37C7E1)),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "AdminXpress est une application mobile conçue pour simplifier vos démarches administratives. "
                  "Grâce à notre interface intuitive, vous pouvez remplir vos formulaires, téléverser vos documents, "
                  "choisir votre mode de livraison et effectuer vos paiements rapidement et en toute sécurité.",
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            Text(
              "Notre mission",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37C7E1)),
            ),
            const SizedBox(height: 8),
            Text(
              "Rendre les démarches administratives accessibles, rapides et sécurisées pour tous, "
                  "en centralisant toutes vos demandes dans une seule application facile à utiliser.",
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            Text(
              "Fonctionnalités clés",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37C7E1)),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildFeatureCard(
                    icon: Icons.upload_file,
                    title: "Téléversement sécurisé",
                    description:
                    "Téléversez vos documents en toute sécurité directement depuis votre téléphone."),
                _buildFeatureCard(
                    icon: Icons.receipt_long,
                    title: "Formulaires simplifiés",
                    description:
                    "Remplissez vos formulaires administratifs facilement sans erreur."),
                _buildFeatureCard(
                    icon: Icons.local_shipping,
                    title: "Choix de livraison",
                    description:
                    "Choisissez entre retrait sur place ou livraison à domicile."),
                _buildFeatureCard(
                    icon: Icons.payment,
                    title: "Paiement sécurisé",
                    description:
                    "Effectuez vos paiements directement via Wave ou autres solutions sécurisées."),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              "Sécurité & confidentialité",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37C7E1)),
            ),
            const SizedBox(height: 8),
            Text(
              "Toutes vos données et documents sont protégés grâce à des protocoles de sécurité avancés. "
                  "Nous respectons votre vie privée et ne partageons aucune information avec des tiers non autorisés.",
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Ici, tu pourrais rediriger vers un contact ou page support
                },
                icon: const Icon(Icons.contact_support),
                label: const Text("Nous contacter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37C7E1),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      {required IconData icon,
        required String title,
        required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Color(0xFF37C7E1)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: const TextStyle(fontSize: 14, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
