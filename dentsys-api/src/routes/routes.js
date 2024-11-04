import express from 'express';
import UserController from '../controllers/user-controller.js';
import PatientController from '../controllers/patient-controller.js';

const router = express.Router();

// auth routes
router.post('/register', UserController.registerUser);
router.post('/login', UserController.loginUser);
// router.post('/logout', logout);

// patient routes
router.post('/add-patient', PatientController.addPatient);
// router.get('/patient/:id', getPatient);
// router.get('/patients', getPatients);
// router.put('/update-patient/:id', updatePatient);
// router.delete('/delete-patient/:id', deletePatient);

export default router;