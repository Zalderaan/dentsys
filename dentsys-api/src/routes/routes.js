import express from 'express';
import UserController from '../controllers/user-controller.js';
import PatientController from '../controllers/patient-controller.js';
import ContactController from '../controllers/contact-controller.js';
import DentalHistoryController from '../controllers/dentalHistory-controller.js';
import InsuranceController from '../controllers/insurance-controller.js';
import MedicalHistoryController from '../controllers/medicalHistory-controller.js';
import PatientConditionController from '../controllers/patientCondition-controller.js';


import TestController from '../controllers/test-controller.js';

const router = express.Router();

// auth routes
router.post('/register', UserController.registerUser);
router.post('/login', UserController.loginUser);
// router.post('/logout', logout);

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

// insruance routes
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
router.put('/change-patient-condition', PatientConditionController.changePatientCondition);
// router.get('/get-patient-condition/:id', PatientConditionController.getPatientCondition);
// router.delete('/delete-patient-condition/:id', PatientConditionController.removePatientCondition);

// test routes
router.post('/test/add-contact', TestController.createContact);
router.get('/test/get-contact/:id', TestController.getContact);
router.put('/test/update-contact/:id', TestController.updateContact);
router.delete('/test/delete-contact/:id', TestController.deleteContact);

export default router;