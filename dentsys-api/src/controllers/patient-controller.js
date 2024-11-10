import Patient from '../models/patient-model.js';
import Contact from '../models/contact-model.js';
import DentalHistory from '../models/dentalHistory-model.js';
import Insurance from '../models/insurance-model.js';
import Allergies from '../models/allergies-model.js';
import MedicalHistory from '../models/medicalHistory-model.js';
import patientCondition from '../models/patientConditon-model.js';

import pool from '../../config/db.js';

export default class PatientController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        console.log('data received:', data);
        const connection = await pool.getConnection();

        try {

            await connection.beginTransaction(); // start transaction

            const newPatient = await Patient.createPatient(data, {transaction: connection}); // insert new patient data
            const newPatientId = newPatient;
            console.log('newPatientId:', newPatientId);

            data.patient_id = newPatientId; // add patient id to contact data
            
            const newContact = await Contact.createContact(data, {transaction: connection}); // insert new contact data
            const newDentalHistory = await DentalHistory.createDentalHist(data, {transaction: connection}); // insert new dental history data
            const newInsurance = await Insurance.createInsurance(data, {transaction: connection}); // insert new insurance data
            const newAllergies = await Allergies.createAllergies(data, {transaction: connection}); // insert new allergies data
            const newPatientConditions = await patientCondition.addPatientConditions(data, {transaction: connection}); // insert new patient conditions data
            const newMedicalHistory = await MedicalHistory.createMedicalHistory(data, {transaction: connection}); // insert new medical history data

            if (!newContact || !newDentalHistory || !newInsurance || !newAllergies || !newPatientConditions || !newMedicalHistory) {
                throw new Error('Error creating patient from controller');
            } else {
                await connection.commit(); // commit transaction
                return res.status(201).json({ 
                    message: 'Patient created successfully from controller', 
                    patient: newPatient, 
                    contact: newContact,
                    dentalHistory: newDentalHistory,
                    insurance: newInsurance,
                    allergies: newAllergies,
                    medicalHistory: newMedicalHistory,
                    patientConditions: newPatientConditions
                });
            }
        } 
        catch (error) {
            await connection.rollback(); // rollback transaction
            res.status(500).json({ error: error.message });
        } finally {
            connection.release(); // release connection
        }
    }

    // GET
    static async getAllPatients(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getPatients(data);
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getPatientDetails(req, res) {
        const patient_id = req.params.id;
        const connection = await pool.getConnection();
        try {
            console.log('patient_data in controller:', patient_id);
            if(!patient_id) {return res.status(400).json({ error: 'Patient ID is required' });}
        
            const patient = await Patient.getOnePatient(patient_id, { connection });
            const contact = await Contact.getContact(patient_id, { connection });
            const dentalHistory = await DentalHistory.getDentalHist(patient_id, { connection });
            const insurance = await Insurance.getInsurance(patient_id, { connection });
            const allergies = await Allergies.getAllergies(patient_id, { connection });
            const medicalHistory = await MedicalHistory.getMedicalHistory(patient_id, { connection });
            const patientConditions = await patientCondition.getPatientConditions(patient_id, { connection });

            if (!patient || patient.length === 0) {return res.status(404).json({ error: 'Patient not found' });}

            return res.status(200).json({
                message: 'Patient retrieved successfully from controller',
                patient: patient,
                contact: contact,
                dentalHistory: dentalHistory,
                insurance: insurance,
                allergies: allergies,
                medicalHistory: medicalHistory,
                patientConditions: patientConditions
            });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async searchPatientsByName(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getPatientByName(data);
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    /* OTHER GET METHODS HERE */
}