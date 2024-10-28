import express from 'express';
import DentistController from '../controllers/dentist-controller.js';

const router = express.Router();

// auth routes
router.post('/register', DentistController.registerDentist);
// router.post('/login', login);
// router.post('/logout', logout);

// // patient routes
// router.post('/add-patient', createPatient);
// router.get('/patient/:id', getPatient);
// router.get('/patients', getPatients);
// router.put('/update-patient/:id', updatePatient);
// router.delete('/delete-patient/:id', deletePatient);

export default router;