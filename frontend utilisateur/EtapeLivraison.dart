
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'EtapePaiement.dart';
import 'StepProgressBar.dart';

class EtapeLivraison extends StatefulWidget {
  final String typeDocument;
  final int quantite;
  final String nom;
  final String prenom;
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

  final Uint8List faceBytes; // Televersement web
  final Uint8List dosBytes;

  const EtapeLivraison({
    Key? key,
    required this.typeDocument,
    required this.quantite,
    required this.nom,
    required this.prenom,
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
    required this.faceBytes,
    required this.dosBytes,
  }) : super(key: key);

  @override
  State<EtapeLivraison> createState() => _EtapeLivraisonState();
}

class _EtapeLivraisonState extends State<EtapeLivraison> {
  String? modeLivraison;
  static const Color mainBlue = Color(0xFF37C7E1);

  // Frais de timbre et service
  static const int fraisTimbreParExemplaire = 200;
  static const int fraisServiceParExemplaire = 200;
  static const int fraisLivraison = 500;

  int get montantTimbre => fraisTimbreParExemplaire * widget.quantite;
  int get montantService => fraisServiceParExemplaire * widget.quantite;
  int get montantLivraison => modeLivraison == "Livraison à domicile" ? fraisLivraison : 0;
  int get montantTotal => montantTimbre + montantService + montantLivraison;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;
    final double horizontalPadding = isMobile ? 16 : 32;
    final double logoHeight = isMobile ? 100 : 200;
    final double buttonWidth = isMobile ? size.width * 0.8 : 150;
    final double buttonHeight = isMobile ? 50 : 50;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: isMobile ? 70 : 90,
        automaticallyImplyLeading: false,
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
            Image.asset('Assets/Images/Logo.png', height: logoHeight),
          ],
        ),
      ),
      body: Column(
        children: [
          StepProgressBar(currentStep: 3, totalSteps: 5),
          SizedBox(height: isMobile ? 12 : 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              "Veuillez choisir un mode de retrait",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  _buildOptionCard(
                      value: "Retrait physique",
                      label: "Retrait physique (gratuit)",
                      icon: Icons.store,
                      isMobile: isMobile),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildOptionCard(
                      value: "Livraison à domicile",
                      label: "Livraison à domicile (500 FCFA)",
                      icon: Icons.delivery_dining,
                      isMobile: isMobile),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 50 : 100),
            child: SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: modeLivraison == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EtapePaiement(
                        typeDocument: widget.typeDocument,
                        quantite: widget.quantite,
                        modeLivraison: modeLivraison!,
                        nom: widget.nom,
                        prenom: widget.prenom,
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
                        montantTimbre: montantTimbre,
                        montantService: montantService,
                        montantLivraison: montantLivraison,
                        montantTotal: montantTotal,
                      ),
                    ),
                  );
                },
                child: Text("Suivant",
                    style: TextStyle(fontSize: isMobile ? 14 : 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String value,
    required String label,
    required IconData icon,
    required bool isMobile,
  }) {
    final bool isSelected = modeLivraison == value;
    return InkWell(
      onTap: () => setState(() => modeLivraison = value),
      child: Card(
        elevation: 3,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 10 : 12),
                decoration: BoxDecoration(
                  color: mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: mainBlue, width: 2)
                      : null,
                ),
                child: Icon(icon, size: isMobile ? 24 : 30, color: mainBlue),
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold)),
              ),
              if (isSelected)
                Icon(Icons.check_circle,
                    color: mainBlue, size: isMobile ? 18 : 20),
            ],
          ),
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'EtapePaiement.dart';
import 'StepProgressBar.dart';

class EtapeLivraison extends StatefulWidget {
  final String typeDocument;
  final int quantite;

  const EtapeLivraison({Key? key, required this.typeDocument, required this.quantite}) : super(key: key);

  @override
  State<EtapeLivraison> createState() => _EtapeLivraisonState();
}

class _EtapeLivraisonState extends State<EtapeLivraison> {
  String? modeLivraison;
  static const Color mainBlue = Color(0xFF37C7E1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
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
          StepProgressBar(currentStep: 2),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Veuillez choisir un mode de retrait",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildOptionCard(value: "physique", label: "Retrait physique", icon: Icons.store),
                  const SizedBox(height: 16),
                  _buildOptionCard(value: "domicile", label: "Livraison à domicile", icon: Icons.delivery_dining),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: modeLivraison == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EtapePaiement(
                        typeDocument: widget.typeDocument,
                        quantite: widget.quantite,
                        modeLivraison: modeLivraison!,
                      ),
                    ),
                  );
                },
                child: const Text("Suivant", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({required String value, required String label, required IconData icon}) {
    final bool isSelected = modeLivraison == value;
    return InkWell(
      onTap: () => setState(() => modeLivraison = value),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? Border.all(color: mainBlue, width: 2) : null,
                ),
                child: Icon(icon, size: 30, color: mainBlue),
              ),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (isSelected) const Icon(Icons.check_circle, color: mainBlue, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
*/