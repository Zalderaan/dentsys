const DentalHistory = require('../models/dentalHistory-model.js');

class DentalHistoryController {
    // POST
    static async addDentalHistory(req, res) {
        const data = req.body;
        try {
            const newDentalHistoryId = await DentalHistory.createDentalHist(data);
            const newDentalHistory = await DentalHistory.getDentalHistByDentalId(newDentalHistoryId);
            return res.status(201).json({ message: 'Dental history created successfully from controller', newDentalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getDentalHistory(req, res) {
        const data = req.params.id;
        try {
            const dentalHistory = await DentalHistory.getDentalHist(data);
            if (dentalHistory.length === 0) throw new Error('Dental history not found');
            return res.status(200).json({ message: 'Dental history retrieved successfully from controller', dentalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async updateDentalHistory(req, res) {
        const data = req.body;
        const patient_id = req.params.id;
        data.patient_id = patient_id;

        try {
            const updDentalHistory = await DentalHistory.updateDentalHist(data);
            return res.status(200).json({message: 'Dental history updated successfully from controller', updDentalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async removeDentalHistory(req, res) {
        const data = req.params.id;

        try {
            const delDentalHistory = await DentalHistory.deleteDentalHist(data);
            return res.status(200).json({ message: 'Dental history deleted successfully from controller', delDentalHistory});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = DentalHistoryController;