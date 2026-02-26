const express = require('express');
const router = express.Router();
const demandeController = require('../controllers/demandeController');

router.post('/', demandeController.createDemande);
router.get('/', demandeController.getAllDemandes);


module.exports = router;
