import Patient from '../models/patient-model.js';

export default class PatientController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        try {
            const newPatient = await Patient.createPatient(data);
            if(!newPatient) throw new Error('Error creating patient');
            return res.status(201).json({ message: 'Patient created successfully from controller', newPatient});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
    
    // GET
    static async getPatientDetails(req, res) {
        const data = req.params.id;
        try {
            const patient = await Patient.getPatientById(data);
            if (patient.length === 0) throw new Error('Patient data not found');
            return res.status(200).json({ message: 'Patient retrieved successfully from controller', patient});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getAllPatients(req, res) {
        const data = req.body;
        try {
            const patients = await Patient.getAllPatients(data);
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