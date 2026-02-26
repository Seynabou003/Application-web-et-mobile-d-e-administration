import 'package:flutter/material.dart';
import 'StepProgressBar.dart';

class PageSuiviDemande extends StatefulWidget {
  @override
  _PageSuiviDemandeState createState() => _PageSuiviDemandeState();
}

class _PageSuiviDemandeState extends State<PageSuiviDemande> {
  final TextEditingController suiviController = TextEditingController();
  String? suiviResultat; // Pour simuler l'affichage du suivi

  @override
  void dispose() {
    suiviController.dispose();
    super.dispose();
  }

  void rechercherSuivi() {
    setState(() {
      // Simulation : si le champ n'est pas vide, on affiche un résultat fictif
      if (suiviController.text.isNotEmpty) {
        suiviResultat =
        "Numéro de suivi : ${suiviController.text}\nStatut : En traitement\nMode de livraison : Retrait physique\nMontant payé : 5000 FCFA";
      } else {
        suiviResultat = null;
      }
    });
  }

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
          children: [

            const SizedBox(height: 20),
            const Text(
              "Suivi de votre demande",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Champ numéro de suivi
            TextFormField(
              controller: suiviController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Entrez votre numéro de suivi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bouton rechercher
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37C7E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: rechercherSuivi,
                child: const Text(
                  "Rechercher",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Résultat simulé
            if (suiviResultat != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    suiviResultat!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
