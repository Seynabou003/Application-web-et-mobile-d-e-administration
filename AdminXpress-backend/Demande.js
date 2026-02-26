const mongoose = require("mongoose");

const demandeSchema = new mongoose.Schema({
  nom: { type: String, required: true },
  prenom: { type: String, required: true },
  typeDocument: { type: String, required: true },
  quantite: { type: Number, required: true },
  fraisTimbre: { type: Number, required: true }, // 200 * quantite
  fraisService: { type: Number, required: true }, // 200 * quantite
  fraisLivraison: { type: Number, required: true }, // 0 ou 500
  montantTotal: { type: Number, required: true },
  modeLivraison: { type: String, required: true }, // "physique" ou "domicile"
  paiement: { type: String, required: true }, // ex: "Wave" ou "OM"
  dateDemande: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Demande", demandeSchema);
