const pool = require('../db');

// Créer une demande
exports.createDemande = async (req, res) => {
  console.log('req.body:', req.body);
  try {
    const {
      nom,
      prenom,
      typeDocument,
      quantite,
      modeLivraison,
      paiement,
    } = req.body;

    if (!nom || !prenom || !typeDocument || !quantite || !modeLivraison || !paiement) {
      return res.status(400).json({ message: "Champs manquants" });
    }

    const fraisTimbre = quantite * 200;
    const fraisService = quantite * 200;
    const fraisLivraison = modeLivraison === 'domicile' ? 500 : 0;
    const montantTotal = fraisTimbre + fraisService + fraisLivraison;

    const [rows] = await pool.query(
      `INSERT INTO demandes 
      (nom, prenom, type_document, quantite, frais_timbre, frais_service, frais_livraison, montant_total, mode_livraison, paiement)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [nom, prenom, typeDocument, quantite, fraisTimbre, fraisService, fraisLivraison, montantTotal, modeLivraison, paiement]
    );

    // rows.insertId contient l'ID du nouvel enregistrement
    res.status(201).json({ id: rows.insertId, nom, prenom, typeDocument, quantite, montantTotal });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err.message });
  }
};

// Récupérer toutes les demandes
exports.getAllDemandes = async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM demandes ORDER BY id DESC');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err.message });
  }
};
