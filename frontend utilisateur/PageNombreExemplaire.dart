import 'package:flutter/material.dart';
import 'Etapeformulaire.dart';

class PageNombreExemplaire extends StatefulWidget {
  final String typeDocument;

  const PageNombreExemplaire({Key? key, required this.typeDocument})
      : super(key: key);

  @override
  _PageNombreExemplairesState createState() => _PageNombreExemplairesState();
}

class _PageNombreExemplairesState extends State<PageNombreExemplaire> {
  int? selectedNumber;
  static const Color mainBlue = Color(0xFF37C7E1);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

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
                  const SizedBox(height: 40),
                  const Text(
                    "Choisissez le nombre d'exemplaires que vous souhaitez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Dropdown du nombre d'exemplaires
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<int>(
                      value: selectedNumber,
                      isExpanded: true,
                      hint: const Text("Sélectionnez le nombre"),
                      underline: const SizedBox(),
                      items: List.generate(
                        5,
                            (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text("${index + 1}"),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedNumber = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Bouton Suivant
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainBlue,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedNumber == null
                          ? null
                          : () {
                        // On passe le type de document et le nombre d'exemplaires à l'étape formulaire
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Etapeformulaire(
                              typeDocument: widget.typeDocument,
                              quantite: selectedNumber!,
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
        ),
      ),
    );
  }
}







/*import 'package:flutter/material.dart';
import 'Etapeformulaire.dart';

class PageNombreExemplaire extends StatefulWidget {
  final String typeDocument;

  const PageNombreExemplaire({Key? key, required this.typeDocument})
      : super(key: key);

  @override
  _PageNombreExemplairesState createState() => _PageNombreExemplairesState();
}

class _PageNombreExemplairesState extends State<PageNombreExemplaire> {
  int? selectedNumber;
  static const Color mainBlue = Color(0xFF37C7E1);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

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
              height: 200, // logo adapté
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
                  const SizedBox(height: 40),
                  const Text(
                    "Choisissez le nombre d'exemplaires que vous souhaitez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Liste déroulante
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<int>(
                      value: selectedNumber,
                      isExpanded: true,
                      hint: const Text("Sélectionnez le nombre"),
                      underline: const SizedBox(),
                      items: List.generate(
                        5,
                            (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text("${index + 1}"),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedNumber = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Bouton Suivant
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainBlue,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedNumber == null
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Etapeformulaire(
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

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

*/