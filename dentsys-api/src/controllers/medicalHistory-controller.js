import MedicalHistory from '../models/medicalHistory-model.js';

export default class MedicalHistoryController {
    // POST
    static async addMedicalHistory(req, res) {
        const data = req.body;
        try {
            const newMedicalHistoryId = await MedicalHistory.createMedicalHistory(data);
            const newMedicalHistory = await MedicalHistory.getByMedicalHistoryId(newMedicalHistoryId);
            return res.status(201).json({ message: 'Medical History created successfully from controller', newMedicalHistory});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getMedicalHistory(req, res) {
        const data = req.params.id;
        try {
            const medicalHistory = await MedicalHistory.getMedicalHistory(data);
            return res.status(200).json({ message: 'Medical History retrieved successfully from controller', medicalHistory});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async updateMedicalHistory(req, res) {
        const data = req.body;
        console.log('data in mh controller update', data);
        const patient_id = req.params.id;
        data.patient_id = patient_id;
        try {
            const updatedMedicalHistory = await MedicalHistory.updateMedicalHistory(data);
            return res.status(200).json({ message: 'Medical History updated successfully from controller', updatedMedicalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async removeMedicalHistory(req, res) {
        const data = req.params.id;
        try {
            const delMedicalHistory = await MedicalHistory.deleteMedicalHistory(data);
            return res.status(200).json({ message: 'Medical History deleted successfully from controller', delMedicalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}