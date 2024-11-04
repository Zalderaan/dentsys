import Patient from '../models/patient-model.js';

export default class PatientController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        try {
            const newPatient = await Patient.createPatient(data);
            return res.status(201).json({ message: 'Patient created successfully from controller', newPatient});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }   
    }

    // GET
    static async getPatients(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getPatients(data);
            return res.status(200).json({ message: 'Patients retrieved successfully from controller', patients});
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