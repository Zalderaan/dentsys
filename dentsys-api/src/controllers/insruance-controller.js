import Insurance from '../models/insurance-model';

export default class InsuranceController {
    // POST
    static async addInsurance(req, res) {
        const data = req.body;
        try {
            const newInsurance = await Insurance.createInsurance(data);
            return res.status(201).json({ message: 'Insurance created successfully from controller', newInsurance});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}