import PatientTreatment from "../models/patientTreatment-model.js";

export default class PatientTreatmentController {
    // POST
    static async addTreatment(req, res) {
        try {
            const data = req.body;
            const newTreatment = await PatientTreatment.createPatientTreatment(data);
            return res.status(201).json({ message: 'New treatment created successfully', newTreatment });
        } catch (error) {
            console.error('Error in addTreatment controller:', error);
            throw error;
        }
    }

    static async getTreatmentsByPatientID(req, res) {
        try {
            const patient_id = req.params.id;
            const treatments = await PatientTreatment.getTrByPatientID(patient_id);
            // console.log('treatments:', treatments);
            return res.status(200).json({ treatments });
        } catch (error) {
            console.error('Error in getTreatmentsByPatientID controller:', error);
            throw error;
        }
    }
}