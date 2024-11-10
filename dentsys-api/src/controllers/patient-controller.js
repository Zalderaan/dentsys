import Patient from '../models/patient-model.js';
import Contact from '../models/contact-model.js';
import DentalHistory from '../models/dentalHistory-model.js';
import Insurance from '../models/insurance-model.js';
import Allergies from '../models/allergies-model.js';
import MedicalHistory from '../models/medicalHistory-model.js';
import patientCondition from '../models/patientConditon-model.js';

import pool from '../../config/db.js';

async function getModelData(modelFunc, patient_id, transaction, modelName) {
    // THIS IS FOR GET METHODS ONLY
    try {
        const result = await modelFunc(patient_id, { transaction });
        if (!result) throw new Error(`Error fetching ${modelName}`);
        return result;
    } catch (error) {
        throw new Error(`Error fetching ${modelName}: ${error.message}`);
    }
}

export default class PatientController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        const patient_data = data.patient_data;
        const contact_data = data.contact_data;
        const dental_data = data.dental_data;
        const insurance_data = data.insurance_data;
        const allergies_data = data.allergies_data;
        const medical_data = data.medical_data;
        const conditions_data = data.conditions_data;
        // console.log('conditions_data', conditions_data);
        // console.log('patient_data:', patient_data);
        // console.log('contact_data:', contact_data);
        // console.log('dental_data:', dental_data);
        // console.log('insurance_data:', insurance_data);
        // console.log('allergies_data:', allergies_data);
        // console.log('medical_data:', medical_data);
        // console.log('conditions_data:', conditions_data);

        // console.log('data received:', data);
        const connection = await pool.getConnection();

        try {

            await connection.beginTransaction(); // start transaction

            const newPatient = await Patient.createPatient(patient_data, { transaction: connection }); // insert new patient data
            const newPatientId = newPatient;
            console.log('newPatientId:', newPatientId);

            contact_data.patient_id = newPatientId; // add patient id to contact data
            dental_data.patient_id = newPatientId; // add patient id to dental history data
            insurance_data.patient_id = newPatientId; // add patient id to insurance data
            allergies_data.patient_id = newPatientId; // add patient id to allergies data
            medical_data.patient_id = newPatientId; // add patient id to medical history data
            conditions_data.patient_id = newPatientId; // add patient id to patient conditions data

            const newContact = await Contact.createContact(contact_data, { transaction: connection }); // insert new contact data
            const newDentalHistory = await DentalHistory.createDentalHist(dental_data, { transaction: connection }); // insert new dental history data
            const newInsurance = await Insurance.createInsurance(insurance_data, { transaction: connection }); // insert new insurance data
            const newAllergies = await Allergies.createAllergies(allergies_data, { transaction: connection }); // insert new allergies data
            const newPatientConditions = await patientCondition.upsertPatientConditions(conditions_data, { transaction: connection }); // insert new patient conditions data
            const newMedicalHistory = await MedicalHistory.createMedicalHistory(medical_data, { transaction: connection }); // insert new medical history data

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
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getPatientDetails(req, res) {
        const patient_id = req.params.id;
        const connection = await pool.getConnection();
        try {
            console.log('patient_data in controller:', patient_id);
            if (!patient_id) { return res.status(400).json({ error: 'Patient ID is required' }); }

            const patient = await getModelData(Patient.getOnePatient, patient_id, connection, 'Patient');
            const contact = await getModelData(Contact.getContact, patient_id, connection, 'Contact');
            const dentalHistory = await getModelData(DentalHistory.getDentalHist, patient_id, connection, 'Dental History');
            const insurance = await getModelData(Insurance.getInsurance, patient_id, connection, 'Insurance');
            const allergies = await getModelData(Allergies.getAllergies, patient_id, connection, 'Allergies');
            const medicalHistory = await getModelData(MedicalHistory.getMedicalHistory, patient_id, connection, 'Medical History');
            const patientConditions = await getModelData(patientCondition.getPatientConditions, patient_id, connection, 'Patient Conditions');

            if (!patient || patient.length === 0) { return res.status(404).json({ error: 'Patient not found' }); }

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
            res.status(500).json({error: error.message });
        }
    }

    static async searchPatientsByName(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getPatientByName(data);
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    /* OTHER GET METHODS HERE */
    
    // PUT
    static async updatePatient(req, res) {            
        // extract data
        const data = req.body;
        const patient_data = data.patient_data;
        const contact_data = data.contact_data;
        const dental_data = data.dental_data;
        const insurance_data = data.insurance_data;
        const allergies_data = data.allergies_data;
        const medical_data = data.medical_data;
        const conditions_data = data.conditions_data;
        const patient_id = req.params.id;
        console.log('patient_id:', patient_id);
        
        // create connection
        const connection = await pool.getConnection();

        try {
            await connection.beginTransaction(); // start transaction

            patient_data.patient_id = patient_id;
            contact_data.patient_id = patient_id;
            dental_data.patient_id = patient_id;
            insurance_data.patient_id = patient_id;
            allergies_data.patient_id = patient_id;
            medical_data.patient_id = patient_id;
            conditions_data.patient_id = patient_id;

            // verify existence of patient
            const updPatient = await Patient.updatePatient(patient_data, { transaction: connection });
            
            const updContact = await Contact.updateContact(contact_data, { transaction: connection });
            const updInsurance = await Insurance.updateInsurance(insurance_data, { transaction: connection });
            const updDentalHistory = await DentalHistory.updateDentalHist(dental_data, { transaction: connection });
            const updAllergies = await Allergies.updateAllergies(allergies_data, { transaction: connection });
            const updMedicalHistory = await MedicalHistory.updateMedicalHistory(medical_data, { transaction: connection });
            const updPatientConditions = await patientCondition.upsertPatientConditions(conditions_data, { transaction: connection });

            if (!updPatient || !updContact || !updInsurance || !updDentalHistory || !updAllergies || !updMedicalHistory || !updPatientConditions) {
                throw new Error('Error updating patient from controller');
            } else {

                
                await connection.commit(); // commit transaction
                return res.status(200).json({
                    patient: updPatient,
                    contact: updContact,
                    insurance: updInsurance,
                    dentalHistory: updDentalHistory,
                    allergies: updAllergies,
                    medicalHistory: updMedicalHistory,
                    patientConditions: updPatientConditions
                });
            }
            
        } catch (error) {
            await connection.rollback(); // rollback transaction
            console.error('Error updating patient from controller', error.message);
            res.status(500).json({ error: error.message });
        } finally {
            connection.release(); // release connection
        }
    }

    // DELETE
    static async removePatient(req, res) {
        const connection = await pool.getConnection();
        if(!connection) return res.status(500).json({ error: 'Error connecting to database' });
        try {
            await connection.beginTransaction();

            const patient_id = req.params.id;
            const delPatient = await Patient.deletePatient(patient_id, { transaction: connection });

            if (!delPatient) {
                throw new Error('Error deleting patient from controller');
            } else {
                await connection.commit();
                return res.status(200).json(delPatient);
            }

        } catch (error) {
            if (connection) await connection.rollback();
            res.status(500).json({ error: error.message });
        } finally {
            if (connection) connection.release();
        }
    }
}
