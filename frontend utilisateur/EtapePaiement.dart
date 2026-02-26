import 'package:flutter/material.dart';
import 'EtapeValidation.dart';
import 'StepProgressBar.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'services/api_service.dart';

class EtapePaiement extends StatefulWidget {
  final String typeDocument;
  final String nom;
  final String prenom;
  final int quantite;
  final String modeLivraison;

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

  final File? faceFile;
  final File? dosFile;

  final int montantTimbre;
  final int montantService;
  final int montantLivraison;
  final int montantTotal;

  const EtapePaiement({
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
    this.faceFile,
    this.dosFile,
    required this.montantTimbre,
    required this.montantService,
    required this.montantLivraison,
    required this.montantTotal,
  }) : super(key: key);

  @override
  State<EtapePaiement> createState() => _EtapePaiementState();
}

class _EtapePaiementState extends State<EtapePaiement> {
  String? selectedPaiement;
  static const Color mainBlue = Color(0xFF37C7E1);

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
            Image.asset('Assets/Images/Logo.png', height: 200),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          StepProgressBar(currentStep: 4, totalSteps: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Aperçu du paiement",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow("Type de document", widget.typeDocument),
                          _buildInfoRow("Frais de timbre", "${widget.montantTimbre} FCFA"),
                          _buildInfoRow("Frais de service", "${widget.montantService} FCFA"),
                          _buildInfoRow("Frais de livraison", "${widget.montantLivraison} FCFA"),
                          const Divider(height: 20),
                          _buildInfoRow("Montant total", "${widget.montantTotal} FCFA", isTotal: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choisissez un moyen de paiement",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildPaiementCard(
                    value: "Wave",
                    label: "Wave",
                    imagePath: "Assets/Images/logo wave.png",
                  ),
                  const SizedBox(height: 16),
                  _buildPaiementCard(
                    value: "Orange Money",
                    label: "Orange Money",
                    imagePath: "Assets/Images/logo om.png",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 180,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: selectedPaiement == null ? null : () async {
                  try {
                    // Lire les fichiers en bytes
                    Uint8List? faceBytes;
                    Uint8List? dosBytes;

                    if (widget.faceFile != null) {
                      faceBytes = await widget.faceFile!.readAsBytes();
                    }
                    if (widget.dosFile != null) {
                      dosBytes = await widget.dosFile!.readAsBytes();
                    }

                    // Créer l'objet Map pour envoyer la demande
                    Map<String, dynamic> demandeData = {
                      "typeDocument": widget.typeDocument,
                      "nom": widget.nom,
                      "prenom": widget.prenom,
                      "quantite": widget.quantite,
                      "modeLivraison": widget.modeLivraison,
                      "paiement": selectedPaiement!,
                      "pere": widget.pere,
                      "mere": widget.mere,
                      "jour": widget.jour,
                      "mois": widget.mois,
                      "annee": widget.annee,
                      "cin": widget.cin,
                      "registre": widget.registre,
                      "region": widget.region,
                      "ville": widget.ville,
                      "commune": widget.commune,
                      "telephone": widget.telephone,
                      "email": widget.email,
                      "montantTimbre": widget.montantTimbre,
                      "montantService": widget.montantService,
                      "montantLivraison": widget.montantLivraison,
                      "montantTotal": widget.montantTotal,
                      "faceFile": faceBytes != null ? base64Encode(faceBytes) : null,
                      "dosFile": dosBytes != null ? base64Encode(dosBytes) : null,
                    };

                    // Appel API
                    final result = await ApiService.envoyerDemande(demandeData);

                    if (result['success']) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Demande envoyée avec succès !"))
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EtapeValidation(
                            typeDocument: widget.typeDocument,
                            nom: widget.nom,
                            prenom: widget.prenom,
                            quantite: widget.quantite,
                            modeLivraison: widget.modeLivraison,
                            pere: widget.pere,
                            mere: widget.mere,
                            jour: widget.jour,
                            mois: widget.mois,
                            annee: widget.annee,
                            cin: widget.cin,
                            registre: widget.registre,
                            region: widget.region,
                            ville: widget.ville,
                            commune: widget.commune,
                            telephone: widget.telephone,
                            email: widget.email,
                            paiement: selectedPaiement!,
                            faceBytes: faceBytes,
                            dosBytes: dosBytes,
                            montantTimbre: widget.montantTimbre,
                            montantService: widget.montantService,
                            montantLivraison: widget.montantLivraison,
                            montantTotal: widget.montantTotal,
                            numeroSuivi: result['data']?['id'].toString() ?? "N/A",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erreur : ${result['message']}"))
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur inattendue : $e"))
                    );
                  }
                },
                child: const Text("Valider la demande"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaiementCard({
    required String value,
    required String label,
    required String imagePath,
  }) {
    final bool isSelected = selectedPaiement == value;
    return GestureDetector(
      onTap: () => setState(() => selectedPaiement = value),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? mainBlue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Image.asset(imagePath, height: 42),
              const SizedBox(width: 16),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (isSelected) const Icon(Icons.check_circle, color: mainBlue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
