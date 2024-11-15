import Allergy from '../models/allergies-model.js';

export default class AllergiesController {
    // POST
    static async addAllergies(req, res) {
        const data = req.body;
        // console.log('received allergy data: ', data);
        try {
            const newAllergy = await Allergy.createAllergies(data);
            // console.log('new allergy: ', newAllergy);
            return res.status(201).json({ message: 'Allergy created successfully from controller', newAllergy });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // GET
    static async getAllergies(req, res) {
        const data = req.params.id;
        try {
            const allergies = await Allergy.getAllergies(data);
            return res.status(200).json({ message: 'Allergies retrieved successfully from controller', allergies });
        } catch (error) {
            res.status(500).json({ error: error.message});
        }
    }

    // PUT
    static async updateAllergies(req, res) {
        const data = req.body;
        try {
            const updatedAllergy = await Allergy.updateAllergies(data);
            return res.status(200).json({ message: 'Allergy updated successfully from controller', updatedAllergy });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    // DELETE
    static async deleteAllergies(req, res) {
        const data = req.params.id;
        try {
            const deletedAllergy = await Allergy.deleteAllergies(data);
            return res.status(200).json({ message: 'Allergy deleted successfully from controller', deletedAllergy });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}