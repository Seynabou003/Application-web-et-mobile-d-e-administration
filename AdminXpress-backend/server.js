require('dotenv').config();
const express = require('express');
const cors = require('cors');
const demandeRoutes = require('./routes/demandeRoutes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/demandes', demandeRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Serveur Node.js démarré sur le port ${PORT}`);
});
