import PatientCondition from '../models/patientCondition-model.js';

export default class PatientConditionController{
    // POST
    static async changePatientCondition(req, res) {
        const data = req.body;
        try {
            const newPatientCondition = await PatientCondition.upsertPatientConditions(data);
            return res.status(201).json({ message: 'Patient Condition created successfully from controller', newPatientCondition});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // GET
    static async getPatientCondition(req, res) {
        const data = req.params.id;
        try {
            const patientCondition = await PatientCondition.getPatientConditions(data);
            return res.status(200).json({ message: 'Patient Condition retrieved successfully from controller', patientCondition});
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    // PUT
    static async updatePatientCondition(req, res) {
        const data = req.body;
        const patient_id = req.params.id;
        data.patient_id = patient_id;

        try {
            const updatedPatientCondition = await PatientCondition.updatePatientCondition(data);
            return res.status(200).json({ message: 'Patient Condition updated successfully from controller', updatedPatientCondition});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // DELETE
    static async removePatientCondition(req, res) {
        const data = req.body;
        try {
            const delPatientCondition = await PatientCondition.removePatientCondition(data);
            return res.status(200).json({ message: 'Patient Condition deleted successfully from controller', delPatientCondition});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // static async removePatientCondition(req, res) {
    //     const data = req.params.id;
    //     try {
    //         const delPatientCondition = await PatientCondition.removePatientCondition(data);
    //         return res.status(200).json({ message: 'Patient Condition deleted successfully from controller', delPatientCondition});
    //     } catch (error) {
    //         res.status(500).json({ error: error.message });
    //     }
    // }
}