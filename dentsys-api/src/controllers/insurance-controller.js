import Insurance from "../models/insurance-model.js";

export default class InsuranceController {
    // POST
    static async addInsurance(req, res) {
        const data = req.body;
        try {
            const newInsuranceId = await Insurance.createInsurance(data);
            const newInsurance = await Insurance.getByInsuranceId(newInsuranceId)
            return res.status(201).json({ message: 'Insurance created successfully from controller', newInsurance});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // GET
    static async getInsurance(req, res) {
        const data = req.params.id;
        try {
            const insurance = await Insurance.getInsurance(data);
            return res.status(200).json({ message: 'Insurance retrieved successfully from controller', insurance});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // PUT
    static async updateInsurance(req, res) {
        const data = req.body;
        const patient_id = req.params.id;
        data.patient_id = patient_id;
        try {
            const updatedInsurance = await Insurance.updateInsurance(data);
            return res.status(200).json({ message: 'Insurance updated successfully from controller', updatedInsurance});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }


    // DELETE
    static async removeInsurance(req, res) {
        const data = req.params.id;
        try {
            const delInsurance = await Insurance.deleteInsurance(data);
            return res.status(200).json({ message: 'Insurance deleted successfully from controller', delInsurance});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}