const express = require("express");
const multer = require("multer");
const cors = require("cors");
const path = require("path");
const pool = require("./db"); // connexion PostgreSQL

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Dossier pour sauvegarder les fichiers
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    // nom unique : timestamp + originalname
    cb(null, Date.now() + "_" + file.originalname);
  },
});
const upload = multer({ storage: storage });

// Route POST pour créer la demande
app.post(
  "/api/demandes",
  upload.fields([
    { name: "faceFile", maxCount: 1 },
    { name: "dosFile", maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const {
        typeDocument,
        nom,
        prenom,
        pere,
        mere,
        jour,
        mois,
        annee,
        cin,
        registre,
        region,
        ville,
        commune,
        telephone,
        email,
        quantite,
        modeLivraison,
        paiement,
        montantTimbre,
        montantService,
        montantLivraison,
        montantTotal,
      } = req.body;

      if (!nom || !prenom || !typeDocument) {
        return res.status(400).json({ message: "Champs obligatoires manquants" });
      }

      const date_naissance = annee && mois && jour ? `${annee}-${mois}-${jour}` : null;

      const faceFile = req.files["faceFile"] ? req.files["faceFile"][0].filename : null;
      const dosFile = req.files["dosFile"] ? req.files["dosFile"][0].filename : null;

      // Insertion SQL
      const result = await pool.query(
        `INSERT INTO demandes
        (type_document, nom, prenom, pere, mere, date_naissance, cin, registre,
         region, ville, commune, telephone, email, quantite, mode_livraison, paiement,
         montant_timbre, montant_service, montant_livraison, montant_total, face_file, dos_file)
        VALUES
        ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22)
        RETURNING *`,
        [
          typeDocument, nom, prenom, pere, mere, date_naissance, cin, registre,
          region, ville, commune, telephone, email, quantite, modeLivraison, paiement,
          montantTimbre, montantService, montantLivraison, montantTotal, faceFile, dosFile
        ]
      );

      res.status(201).json({
        message: "Demande reçue et enregistrée avec succès",
        demande: result.rows[0],
      });

    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Erreur serveur", error: error.message });
    }
  }
);

app.listen(PORT, () => {
  console.log(`Serveur démarré sur http://localhost:${PORT}`);
});
