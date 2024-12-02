const Contact = require('../models/contact-model.js');
const Patient = require('../models/patient-model.js');
const DentalHistory = require('../models/dentalHistory-model.js');
const Insurance = require('../models/insurance-model.js');
const Allergies = require('../models/allergies-model.js');
const MedicalHistory = require('../models/medicalHistory-model.js');
const PatientCondition = require('../models/patientCondition-model.js');

class PatientController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        console.log('data received in controller:', data);
        try {
            const newPatientId = await Patient.createPatient(data);
            const newPatient = await Patient.getPatientById(newPatientId);
            if(!newPatient) {
                throw new Error('Error creating patient');
            } else if (newPatient) {
                console.log('Patient created successfully from controller:', newPatient);
                return res.status(201).json({ message: 'Patient created successfully from controller', newPatient});
            }
        } 
        catch (error) {
            console.error('Error creating patient from controller', error);
            res.status(500).json({ error: error.message });
        }
    }
    
    // GET
    static async getPatientDetails(req, res) {
        const data = req.params.id;
        try {
            const patient = await Patient.getPatientById(data);
            const contact = await Contact.getContact(data);
            const dentalHistory = await DentalHistory.getDentalHist(data); // OK
            const insurance = await Insurance.getInsurance(data);
            const allergies = await Allergies.getAllergies(data);
            const medicalHistory = await MedicalHistory.getMedicalHistory(data);
            const patientCondition = await PatientCondition.getPatientConditions(data); // OK

            const patientDetails = {patient, contact, dentalHistory, insurance, allergies, medicalHistory, patientCondition};
            
            if (patient.length === 0) throw new Error('Patient data not found');
            return res.status(200).json({ message: 'Patient retrieved successfully from controller', patientDetails});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getAllPatients(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getAllPatients(data);
            // console.log('Patients retrieved successfully from controller:', patients);
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // PUT
    static async updatePatient(req, res) {
        const data = req.body;
        data.patient_id = req.params.id;

        try {
            const updatedPatient = await Patient.updatePatient(data);
            return res.status(200).json({
                message: 'Patient updated successfully from controller', updatedPatient});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // DELETE

    static async removePatient(req, res) {
        const data = req.params.id;
        try {
            const delPatient = await Patient.deletePatient(data);
            return res.status(200).json({ message: 'Patient deleted successfully from controller', delPatient});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = PatientController;