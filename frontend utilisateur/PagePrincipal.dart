import 'dart:async';
import 'package:flutter/material.dart';
import 'PageDemande.dart';
import 'PageSuiviDemande.dart';

import 'PageAPropos.dart';

class PagePrincipal extends StatefulWidget {
  @override
  State<PagePrincipal> createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late Timer _timer;

  static const Color mainBlue = Color(0xFF37C7E1);
  static const double cardWidth = 220;
  static const double cardHeight = 230;

  final List<Map<String, String>> testimonials = [
    {
      "user": "Aissatou D.",
      "comment":
      "Grâce à AdminXpress, j'ai pu faire ma demande de manière rapide et sécurisée !"
    },
    {
      "user": "Mamadou S.",
      "comment":
      "Application très pratique et intuitive, je la recommande."
    },
    {
      "user": "Fatou N.",
      "comment": "Service rapide et simple, j'adore !"
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _currentPage = (_currentPage + 1) % testimonials.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.white,

      /* ================= APP BAR ================= */
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset(
                'Assets/Images/Logo2.png',
                height: 80,
              ),

              const Spacer(),

              if (!isMobile)
                Row(
                  children: [
                    _menuItem("Faire une demande", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PageDemande()));
                    }),
                    _menuItem("Suivi d’une demande", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PageSuiviDemande()));
                    }),

                    _menuItem("À propos", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PageAPropos()));
                    }),
                  ],
                ),


            ],
          ),
        ),
      ),

      /* ================= BODY ================= */
      body: SingleChildScrollView(
        child: Column(
          children: [

            /* ========== HERO ========== */
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/Images/imagelanding.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  color: Colors.black.withOpacity(0.3),
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "L'application qui simplifie vos démarches administratives au Sénégal en quelques clics.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainBlue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PageDemande()));
                            },
                            child: const Text("Faire une demande",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            _sectionTitle("Comment ça marche ?"),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _uniformCard(
                    Icons.edit_document,
                    "Remplissez le formulaire",
                    "Saisissez vos informations personnelles rapidement.",
                  ),
                  _uniformCard(
                    Icons.upload_file,
                    "Téléversez vos documents",
                    "Envoyez vos documents nécessaires en toute sécurité.",
                  ),
                  _uniformCard(
                    Icons.local_shipping,
                    "Choisir la méthode de livraison",
                    "Retrait physique ou livraison à domicile.",
                  ),
                  _uniformCard(
                    Icons.payment,
                    "Effectuer le paiement",
                    "Payez facilement via Wave ou Orange Money.",
                  ),
                  _uniformCard(
                    Icons.check_circle,
                    "Validation et suivi",
                    "Recevez la confirmation et votre numéro de suivi.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            _sectionTitle("Pourquoi utiliser AdminXpress ?"),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _uniformCard(
                    Icons.speed,
                    "Rapide et efficace",
                    "Complétez vos démarches en quelques minutes, sans file d'attente.",
                  ),
                  _uniformCard(
                    Icons.lock,
                    "Sécurité et confidentialité",
                    "Vos informations et vos documents sont protégés.",
                  ),
                  _uniformCard(
                    Icons.support,
                    "Support disponible",
                    "Un accompagnement personnalisé en cas de besoin.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            _sectionTitle("Retour de nos utilisateurs"),
            const SizedBox(height: 20),

            SizedBox(
              height: cardHeight + 20,
              child: PageView.builder(
                controller: _pageController,
                itemCount: testimonials.length,
                itemBuilder: (context, index) {
                  return _testimonialUniformCard(
                    testimonials[index]["user"]!,
                    testimonials[index]["comment"]!,
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  "© 2025 AdminXpress. Tous droits réservés.",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ================= WIDGETS ================= */

  Widget _menuItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, color: mainBlue),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    );
  }

  Widget _uniformCard(IconData icon, String title, String desc) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: mainBlue),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _testimonialUniformCard(String user, String comment) {
    return Center(
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: mainBlue,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(user,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  comment,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
