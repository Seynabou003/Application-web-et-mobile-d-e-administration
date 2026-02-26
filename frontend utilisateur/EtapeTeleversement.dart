import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'EtapeLivraison.dart';
import 'StepProgressBar.dart';
import 'package:file_picker/file_picker.dart';

class EtapeTeleversement extends StatefulWidget {
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

  const EtapeTeleversement({
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
  }) : super(key: key);

  @override
  State<EtapeTeleversement> createState() => _EtapeTeleversementState();
}

class _EtapeTeleversementState extends State<EtapeTeleversement> {
  File? faceFile;
  File? dosFile;
  Uint8List? faceBytes;
  Uint8List? dosBytes;   // pour le web

  final picker = ImagePicker();

  Future<void> pickImage(bool isFace) async {
    if (kIsWeb) {
      // Sur le web, utiliser FilePicker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          if (isFace) {
            faceBytes = result.files.single.bytes;
            faceFile = null;
          } else {
            dosBytes = result.files.single.bytes;
            dosFile = null;
          }
        });
      }
    } else {
      // Sur mobile
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (isFace) {
            faceFile = File(pickedFile.path);
            faceBytes = null;
          } else {
            dosFile = File(pickedFile.path);
            dosBytes = null;
          }
        });
      }
    }
  }

  bool isValidFile() {
    // Vérifie si au moins un fichier a été choisi
    if (kIsWeb) {
      return (faceBytes != null && dosBytes != null);
    } else {
      return (faceFile != null && dosFile != null);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StepProgressBar(currentStep: 2, totalSteps: 5),
            const SizedBox(height: 20),
            const Text(
              "Veuillez téléverser votre carte d'identité",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isDesktop = constraints.maxWidth > 600;
                double cardWidth = isDesktop
                    ? (constraints.maxWidth - 20) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildUploadCard(
                      width: cardWidth,
                      label: "Face de la carte",
                      file: faceFile,
                      bytes: faceBytes,
                      onTap: () => pickImage(true),
                    ),
                    _buildUploadCard(
                      width: cardWidth,
                      label: "Dos de la carte",
                      file: dosFile,
                      bytes: dosBytes,
                      onTap: () => pickImage(false),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "*jpg, *jpeg, *png, *pdf uniquement",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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
                onPressed: () {
                  // Vérifie que les deux fichiers sont téléversés
                  if (faceBytes == null || dosBytes == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez téléverser les deux fichiers"),
                      ),
                    );
                    return;
                  }

                  // Navigation vers EtapeLivraison (Web)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EtapeLivraison(
                        typeDocument: widget.typeDocument,
                        quantite: widget.quantite,
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
                        faceBytes: faceBytes!, // on est sûr qu'ils ne sont pas null
                        dosBytes: dosBytes!,
                      ),
                    ),
                  );
                },

                child:
                const Text("Suivant", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required double width,
    required String label,
    File? file,
    Uint8List? bytes,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: width,
          height: 180,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: (file == null && bytes == null)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 50, color: Color(0xFF37C7E1)),
              const SizedBox(height: 12),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          )
              : (kIsWeb
              ? Image.memory(bytes!, fit: BoxFit.cover, width: width, height: 180)
              : Image.file(file!, fit: BoxFit.cover, width: width, height: 180)),
        ),
      ),
    );
  }
}


/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'EtapeLivraison.dart';
import 'StepProgressBar.dart';

class EtapeTeleversement extends StatefulWidget {
  final String typeDocument;

  const EtapeTeleversement({Key? key, required this.typeDocument}) : super(key: key);

  @override
  State<EtapeTeleversement> createState() => _EtapeTeleversementState();
}

class _EtapeTeleversementState extends State<EtapeTeleversement> {
  File? faceFile;
  File? dosFile;

  final picker = ImagePicker();

  Future<void> pickImage(bool isFace) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFace) {
          faceFile = File(pickedFile.path);
        } else {
          dosFile = File(pickedFile.path);
        }
      });
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StepProgressBar(currentStep: 1),
              const SizedBox(height: 20),

              const Text(
                "Veuillez téléverser votre carte d'identité",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Cards côte à côte sur desktop, empilées sur mobile
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isDesktop = constraints.maxWidth > 600;
                  double cardWidth = isDesktop
                      ? (constraints.maxWidth - 20) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildUploadCard(
                        width: cardWidth,
                        label: "Face de la carte",
                        file: faceFile,
                        onTap: () => pickImage(true),
                      ),
                      _buildUploadCard(
                        width: cardWidth,
                        label: "Dos de la carte",
                        file: dosFile,
                        onTap: () => pickImage(false),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // Note formats acceptés
              const Text(
                "*jpg, *png, *pdf uniquement",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Bouton Suivant
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
                  // On supprime la vérification des fichiers
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EtapeLivraison(
                          typeDocument: widget.typeDocument, quantite: 1,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Suivant",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required double width,
    required String label,
    required File? file,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: width,
          height: 180,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: file == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 50, color: Color(0xFF37C7E1)),
              const SizedBox(height: 12),
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(file, fit: BoxFit.cover, width: width, height: 180),
          ),
        ),
      ),
    );
  }
}
*/