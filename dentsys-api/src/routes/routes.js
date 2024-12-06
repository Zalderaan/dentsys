const express = require('express');
const UserController = require('../controllers/user-controller.js');
const PatientController = require('../controllers/patient-controller.js');
const ContactController = require('../controllers/contact-controller.js');
const DentalHistoryController = require('../controllers/dentalHistory-controller.js');
const InsuranceController = require('../controllers/insurance-controller.js');
const MedicalHistoryController = require('../controllers/medicalHistory-controller.js');
const PatientConditionController = require('../controllers/patientCondition-controller.js');
const AllergiesController = require('../controllers/allergies-controller.js');
const ProcedureController = require('../controllers/procedure-controller.js');
const PatientTreatmentController = require('../controllers/patientTreatment-controller.js');
const BackupController = require('../controllers/backup-controller.js');

const router = express.Router();

// auth routes
router.post('/register', UserController.registerUser);
router.post('/login', UserController.loginUser);
// router.post('/logout', logout);

// patient full detail routes

// patient routes
router.post('/add-patient', PatientController.addPatient);
router.get('/patients/:id', PatientController.getPatientDetails);
router.get('/patients', PatientController.getAllPatients);
router.put('/update-patient/:id', PatientController.updatePatient);
router.delete('/delete-patient/:id', PatientController.removePatient);

// contact routes
router.post('/add-contact', ContactController.addContact);
router.get('/get-contact/:id', ContactController.getContact);
router.put('/update-contact/:id', ContactController.updateContact);
router.delete('/delete-contact/:id', ContactController.removeContact);

// dental history routes
router.post('/add-dental-history', DentalHistoryController.addDentalHistory);
router.get('/get-dental-history/:id', DentalHistoryController.getDentalHistory);
router.put('/update-dental-history/:id', DentalHistoryController.updateDentalHistory);
router.delete('/delete-dental-history/:id', DentalHistoryController.removeDentalHistory);

// insurance routes
router.post('/add-insurance', InsuranceController.addInsurance);
router.get('/get-insurance/:id', InsuranceController.getInsurance);
router.put('/update-insurance/:id', InsuranceController.updateInsurance);
router.delete('/delete-insurance/:id', InsuranceController.removeInsurance);

// medical history routes
router.post('/add-medical-history', MedicalHistoryController.addMedicalHistory);
router.get('/get-medical-history/:id', MedicalHistoryController.getMedicalHistory);
router.put('/update-medical-history/:id', MedicalHistoryController.updateMedicalHistory);
router.delete('/delete-medical-history/:id', MedicalHistoryController.removeMedicalHistory);

// patient condition routes
router.put('/change-patient-conditions', PatientConditionController.changePatientCondition);
router.get('/get-patient-conditions/:id', PatientConditionController.getPatientCondition);
router.delete('/delete-patient-conditions/:id', PatientConditionController.removePatientCondition);

// allergies routes
router.post('/add-allergies', AllergiesController.addAllergies);
router.get('/get-allergies/:id', AllergiesController.getAllergies);
router.put('/update-allergies/:id', AllergiesController.updateAllergies);
router.delete('/delete-allergies/:id', AllergiesController.deleteAllergies);

// procedures routes
router.post('/add-procedure', ProcedureController.addProcedure);
router.get('/get-procedures', ProcedureController.getAllProcedures);
router.put('/update-procedure/:id', ProcedureController.updateProcedure);
router.delete('/delete-procedure/:id', ProcedureController.deleteProcedure);

// treatment routes
router.post('/add-treatment', PatientTreatmentController.addTreatment);
router.get('/get-treatments/:id', PatientTreatmentController.getTreatmentsByPatientID);
router.get('/get-last-balance/:id', PatientTreatmentController.getPatientLastBalance);
router.get('/get-balance-before-treatment/:pid/:tid', PatientTreatmentController.getBalanceBeforeTreatment);
router.put('/update-treatment/:id', PatientTreatmentController.updateTreatment);
router.delete('/delete-treatment/:id', PatientTreatmentController.deleteTreatment);

// backup routes
router.post('/backup', BackupController.backup);
router.post('/restore', BackupController.restore);

module.exports = router;