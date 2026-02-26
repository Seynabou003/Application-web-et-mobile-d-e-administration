import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'StepProgressBar.dart';

class EtapeValidation extends StatelessWidget {
  final String typeDocument;
  final String nom;
  final String prenom;
  final int quantite;
  final String modeLivraison;
  final String paiement;

  // Infos complètes
  final String pere;
  final String mere;
  final String jour;
  final String mois;
  final String annee;
  final String cin;
  final String registre;
  final String region;
  final String ville;
  final String commune;
  final String telephone;
  final String email;

  // Pour le Web, on récupère les fichiers sous forme de bytes
  final Uint8List? faceBytes;
  final Uint8List? dosBytes;

  final int montantTimbre;
  final int montantService;
  final int montantLivraison;
  final int montantTotal;

  // ✅ Numéro de suivi renvoyé par le serveur
  final String numeroSuivi;

  const EtapeValidation({
    Key? key,
    required this.typeDocument,
    required this.nom,
    required this.prenom,
    required this.quantite,
    required this.modeLivraison,
    required this.pere,
    required this.mere,
    required this.jour,
    required this.mois,
    required this.annee,
    required this.cin,
    required this.registre,
    required this.region,
    required this.ville,
    required this.commune,
    required this.telephone,
    required this.email,
    required this.paiement,
    this.faceBytes,
    this.dosBytes,
    required this.montantTimbre,
    required this.montantService,
    required this.montantLivraison,
    required this.montantTotal,
    required this.numeroSuivi,
  }) : super(key: key);

  /// Fonction pour envoyer la demande au serveur
  /// Retourne le numéro de suivi si succès, sinon null
  Future<String?> envoyerDemande(BuildContext context) async {
    var uri = Uri.parse("http://localhost:5000/api/demandes");
    var request = http.MultipartRequest('POST', uri);

    // Ajouter tous les champs texte
    request.fields.addAll({
      'typeDocument': typeDocument,
      'nom': nom,
      'prenom': prenom,
      'pere': pere,
      'mere': mere,
      'jour': jour,
      'mois': mois,
      'annee': annee,
      'cin': cin,
      'registre': registre,
      'region': region,
      'ville': ville,
      'commune': commune,
      'telephone': telephone,
      'email': email,
      'quantite': quantite.toString(),
      'modeLivraison': modeLivraison,
      'paiement': paiement,
      'montantTimbre': montantTimbre.toString(),
      'montantService': montantService.toString(),
      'montantLivraison': montantLivraison.toString(),
      'montantTotal': montantTotal.toString(),
    });

    // Ajouter fichiers si présents
    if (faceBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'faceFile',
        faceBytes!,
        filename: 'face.png',
        contentType: MediaType('image', 'png'),
      ));
    }

    if (dosBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'dosFile',
        dosBytes!,
        filename: 'dos.png',
        contentType: MediaType('image', 'png'),
      ));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Supposons que le serveur renvoie {"numeroSuivi":"12345"}
        final match = RegExp(r'"numeroSuivi"\s*:\s*"(\w+)"').firstMatch(respStr);
        final numero = match != null ? match.group(1) : "N/A";

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Demande envoyée avec succès !")),
        );
        return numero;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'envoi: $respStr")),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: $e")),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('Assets/Images/Logo.png', height: 200),
        ),
      ),
      body: Column(
        children: [
          StepProgressBar(currentStep: 5, totalSteps: 5),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "Demande validée avec succès !",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow("Type de document", typeDocument),
                              _buildInfoRow("Nom", nom),
                              _buildInfoRow("Prénom", prenom),
                              _buildInfoRow("Mode de livraison", modeLivraison),
                              _buildInfoRow("Moyen de paiement", paiement),
                              _buildInfoRow("Montant total payé", "$montantTotal FCFA", isTotal: true),
                              _buildInfoRow("Numéro de suivi", numeroSuivi),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF37C7E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text(
                        "Retour à l'accueil",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
          Text(value, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
        ],
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'StepProgressBar.dart';

class EtapeValidation extends StatelessWidget {
  // Simuler les données de la demande
  final String numeroDemande = "ADM-2025-00123";
  final String typeDocument = "Extrait de naissance";
  final String nom = "DIONE";
  final String prenom = "Seynabou";
  final String modeLivraison = "Retrait physique";
  final String paiement = "Wave";
  final double montant = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar sans flèche
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false, // Supprime la flèche de retour
        title: Center(
          child: Image.asset('Assets/Images/Logo.png', height: 200),
        ),
      ),

      body: Column(
        children: [
          StepProgressBar(currentStep: 4, totalSteps: 5),
          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "Demande validée avec succès !",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Card résumé de la demande (largeur réduite)
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow("Numéro de demande", numeroDemande),
                              _buildInfoRow("Type de document", typeDocument),
                              _buildInfoRow("Nom", nom),
                              _buildInfoRow("Prénom", prenom),
                              _buildInfoRow("Mode de livraison", modeLivraison),
                              _buildInfoRow("Paiement", paiement),
                              _buildInfoRow("Montant payé", "$montant FCFA"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF37C7E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text(
                        "Retour à l'accueil",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour une ligne d'information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
*/