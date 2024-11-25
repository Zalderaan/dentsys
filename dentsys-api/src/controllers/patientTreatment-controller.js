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
}