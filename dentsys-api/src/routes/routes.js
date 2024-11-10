import express from 'express';
import UserController from '../controllers/user-controller.js';
import PatientController from '../controllers/patient-controller.js';
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

// test routes
router.post('/test/add-contact', TestController.createContact);
router.get('/test/get-contact/:id', TestController.getContact);

export default router;