import 'package:flutter/material.dart';
import 'package:adminxpressv1/EtapeTeleversement.dart';
import 'StepProgressBar.dart';

class Etapeformulaire extends StatefulWidget {
  final String typeDocument;
  final int quantite;

  const Etapeformulaire({
    Key? key,
    required this.typeDocument,
    required this.quantite,
  }) : super(key: key);

  @override
  State<Etapeformulaire> createState() => _EtapeFormulaireState();
}

class _EtapeFormulaireState extends State<Etapeformulaire> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final pereController = TextEditingController();
  final mereController = TextEditingController();
  final anneeController = TextEditingController();
  final cinController = TextEditingController();
  final registreController = TextEditingController();
  final regionController = TextEditingController();
  final villeController = TextEditingController();
  final communeController = TextEditingController();
  final telephoneController = TextEditingController();
  final emailController = TextEditingController();

  // Date
  String? selectedJour;
  String? selectedMois;

  final jours = List.generate(31, (index) => (index + 1).toString());
  final mois = [
    "Janvier","Février","Mars","Avril","Mai","Juin","Juillet",
    "Août","Septembre","Octobre","Novembre","Décembre"
  ];

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    pereController.dispose();
    mereController.dispose();
    anneeController.dispose();
    cinController.dispose();
    registreController.dispose();
    regionController.dispose();
    villeController.dispose();
    communeController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    // Adaptations responsive en fonction de l'appareil
    final padding = isDesktop ? 24.0 : 16.0;
    final fontSizeTitle = isDesktop ? 20.0 : 18.0;
    final fontSizeLabel = isDesktop ? 16.0 : 14.0;
    final buttonWidth = isDesktop ? 180.0 : 150.0;
    final buttonHeight = 50.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: isDesktop ? 90 : 70,
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
              height: isDesktop ? 200 : 150,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 700 : double.infinity),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  StepProgressBar(currentStep: 1, totalSteps: 5),
                  const SizedBox(height: 20),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Informations du demandeur",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 15),

                        _buildTextField("Nom", nomController, fontSize: fontSizeLabel),
                        _buildTextField("Prénom(s)", prenomController, fontSize: fontSizeLabel),
                        _buildTextField("Nom et prénom du père", pereController, fontSize: fontSizeLabel),
                        _buildTextField("Nom et prénom de la mère", mereController, fontSize: fontSizeLabel),

                        const SizedBox(height: 15),
                        Text(
                          "Date de naissance",
                          style: TextStyle(
                            fontSize: fontSizeLabel,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedJour,
                                hint: const Text("Jour"),
                                decoration: _inputDecoration(),
                                items: jours.map((jour) => DropdownMenuItem(
                                  value: jour,
                                  child: Text(jour, style: TextStyle(fontSize: fontSizeLabel)),
                                )).toList(),
                                onChanged: (val) => setState(() => selectedJour = val),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedMois,
                                hint: const Text("Mois"),
                                decoration: _inputDecoration(),
                                items: mois.map((mois) => DropdownMenuItem(
                                  value: mois,
                                  child: Text(mois, style: TextStyle(fontSize: fontSizeLabel)),
                                )).toList(),
                                onChanged: (val) => setState(() => selectedMois = val),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: anneeController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration(label: "Année"),
                                style: TextStyle(fontSize: fontSizeLabel),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        _buildTextField("Numéro CIN", cinController, fontSize: fontSizeLabel),
                        _buildTextField("Numéro registre (si pas de CIN)", registreController, fontSize: fontSizeLabel),
                        _buildTextField("Région", regionController, fontSize: fontSizeLabel),
                        _buildTextField("Ville", villeController, fontSize: fontSizeLabel),
                        _buildTextField("Commune", communeController, fontSize: fontSizeLabel),
                        _buildTextField("Numéro de téléphone", telephoneController, keyboard: TextInputType.phone, fontSize: fontSizeLabel),
                        _buildTextField("Email (facultatif)", emailController, keyboard: TextInputType.emailAddress, fontSize: fontSizeLabel),

                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            width: buttonWidth,
                            height: buttonHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF37C7E1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EtapeTeleversement(
                                        typeDocument: widget.typeDocument,
                                        quantite: widget.quantite,
                                        nom: nomController.text,
                                        prenom: prenomController.text,
                                        pere: pereController.text,
                                        mere: mereController.text,
                                        jour: selectedJour ?? "",
                                        mois: selectedMois ?? "",
                                        annee: anneeController.text,
                                        cin: cinController.text,
                                        registre: registreController.text,
                                        region: regionController.text,
                                        ville: villeController.text,
                                        commune: communeController.text,
                                        telephone: telephoneController.text,
                                        email: emailController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Suivant", style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? label}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboard = TextInputType.text,
        double fontSize = 14,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        style: TextStyle(fontSize: fontSize),
        decoration: _inputDecoration(label: label),
        validator: (value) {
          if ((value == null || value.isEmpty) && label != "Email (facultatif)") {
            return "Veuillez remplir ce champ";
          }
          return null;
        },
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:adminxpressv1/EtapeTeleversement.dart';
import 'PagePrincipal.dart';
import 'StepProgressBar.dart';

class Etapeformulaire extends StatefulWidget {
  final String typeDocument;

  const Etapeformulaire({Key? key, required this.typeDocument, requir, required, }) : super(key: key);

get quantite => null;

@override
State<Etapeformulaire> createState() => _EtapeFormulaireState();
}

class _EtapeFormulaireState extends State<Etapeformulaire> {
final _formKey = GlobalKey<FormState>();

// Controllers
final nomController = TextEditingController();
final prenomController = TextEditingController();
final pereController = TextEditingController();
final mereController = TextEditingController();
final anneeController = TextEditingController();
final cinController = TextEditingController();
final registreController = TextEditingController(); // nouveau champ
final regionController = TextEditingController();
final villeController = TextEditingController();
final communeController = TextEditingController();
final telephoneController = TextEditingController();
final emailController = TextEditingController();

// Date
String? selectedJour;
String? selectedMois;

final jours = List.generate(31, (index) => (index + 1).toString());
final mois = [
"Janvier","Février","Mars","Avril","Mai","Juin","Juillet",
"Août","Septembre","Octobre","Novembre","Décembre"
];

@override
void dispose() {
nomController.dispose();
prenomController.dispose();
pereController.dispose();
mereController.dispose();
anneeController.dispose();
cinController.dispose();
registreController.dispose();
regionController.dispose();
villeController.dispose();
communeController.dispose();
telephoneController.dispose();
emailController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final bool isDesktop = MediaQuery.of(context).size.width > 900;

return Scaffold(
backgroundColor: Colors.white,

// AppBar avec logo centré et flèche retour
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
child: Center(
child: ConstrainedBox(
constraints: BoxConstraints(
maxWidth: isDesktop ? 700 : double.infinity,
),
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const SizedBox(height: 20),

StepProgressBar(currentStep: 0),
const SizedBox(height: 20),

Form(
key: _formKey,
child: Column(
children: [
const Text(
"Informations du demandeur",
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.black87,
),
),
const SizedBox(height: 15),

_buildTextField("Nom", nomController),
_buildTextField("Prénom(s)", prenomController),
_buildTextField("Prénom(s) et nom du père", pereController),
_buildTextField("Prénom(s) et nom de la mère", mereController),

const SizedBox(height: 15),
const Text(
"Date de naissance",
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
color: Colors.black87,
),
),
const SizedBox(height: 8),

Row(
children: [
Expanded(
child: DropdownButtonFormField<String>(
value: selectedJour,
hint: const Text("Jour"),
decoration: _inputDecoration(),
items: jours.map((jour) => DropdownMenuItem(
value: jour,
child: Text(jour),
)).toList(),
onChanged: (val) {
setState(() => selectedJour = val);
},
),
),
const SizedBox(width: 10),
Expanded(
child: DropdownButtonFormField<String>(
value: selectedMois,
hint: const Text("Mois"),
decoration: _inputDecoration(),
items: mois.map((mois) => DropdownMenuItem(
value: mois,
child: Text(mois),
)).toList(),
onChanged: (val) {
setState(() => selectedMois = val);
},
),
),
const SizedBox(width: 10),
Expanded(
child: TextFormField(
controller: anneeController,
keyboardType: TextInputType.number,
decoration: _inputDecoration(label: "Année"),
),
),
],
),

const SizedBox(height: 15),
_buildTextField("Numéro CIN", cinController),

// Nouveau champ registre
_buildTextField(
"Numéro registre (si pas de CIN)",
registreController,
),

_buildTextField("Région", regionController),
_buildTextField("Ville", villeController),
_buildTextField("Commune", communeController),
_buildTextField(
"Numéro de téléphone",
telephoneController,
keyboard: TextInputType.phone,
),
_buildTextField(
"Email (facultatif)",
emailController,
keyboard: TextInputType.emailAddress,
),

const SizedBox(height: 30),
Center(
child: SizedBox(
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
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => EtapeTeleversement(
typeDocument: widget.typeDocument,

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
),
const SizedBox(height: 20),
],
),
),
],
),
),
),
),
),
);
}

InputDecoration _inputDecoration({String? label}) {
return InputDecoration(
labelText: label,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
),
contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
);
}

Widget _buildTextField(
String label,
TextEditingController controller, {
TextInputType keyboard = TextInputType.text,
}) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 8),
child: TextFormField(
controller: controller,
keyboardType: keyboard,
decoration: _inputDecoration(label: label),
),
);
}
}
*/