import 'dart:convert';
import 'dart:html' as html; // Flutter Web download
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List demandes = [];
  bool isLoading = true;

  final String apiUrl = "http://localhost:5000/api/demandes";

  @override
  void initState() {
    super.initState();
    fetchDemandes();
  }

  Future<void> fetchDemandes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          demandes = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Erreur API: $e");
      setState(() => isLoading = false);
    }
  }

  int selectedIndex = 0;

  final options = [
    'Toutes les demandes',
    'Demandes en attente',
    'Demandes traitées',
    'Paramètres',
    'Déconnexion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Admin - Gestion des demandes',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset('Assets/Images/Logo.png', height: 100),
              ),
            ),
            ...List.generate(options.length, (index) {
              return ListTile(
                selected: selectedIndex == index,
                selectedTileColor: Colors.blue.shade50,
                leading: Icon(Icons.circle,
                    color: selectedIndex == index
                        ? Colors.blue
                        : Colors.grey,
                    size: 12),
                title: Text(options[index]),
                onTap: () {
                  setState(() => selectedIndex = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Liste des demandes',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700]),
            ),
            const SizedBox(height: 20),

            /// 🔄 Loading
            if (isLoading)
              const Center(child: CircularProgressIndicator()),

            /// 📦 Liste dynamique depuis la BDD
            if (!isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: demandes.length,
                  itemBuilder: (context, index) {
                    final d = demandes[index];

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${d['nom']} ${d['prenom']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Document: ${d['type_document']}'),
                                  Text(
                                    'Montant total: ${d['montant_total']} FCFA',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Livraison: ${d['mode_livraison']}'),
                                  Text(
                                      'Paiement: ${d['paiement']}'),
                                ],
                              ),
                            ),

                            /// 📥 Téléchargement pièces
                            Row(
                              children: [
                                if (d['face_path'] != null)
                                  IconButton(
                                    icon: const Icon(Icons.download,
                                        color: Colors.blue),
                                    onPressed: () {
                                      html.window.open(
                                          'http://localhost:5000/${d['face_path']}',
                                          '_blank');
                                    },
                                  ),
                                if (d['dos_path'] != null)
                                  IconButton(
                                    icon: const Icon(Icons.download,
                                        color: Colors.blue),
                                    onPressed: () {
                                      html.window.open(
                                          'http://localhost:5000/${d['dos_path']}',
                                          '_blank');
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
