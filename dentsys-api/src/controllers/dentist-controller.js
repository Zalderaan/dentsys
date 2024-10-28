import Dentist from '../models/dentist-model.js';

export default class DentistController {
    static async registerDentist(req, res) {
        try {
            const newDentist = await Dentist.createDentist(req.body);
            res.status(201).json({ message: 'Dentist created successfully from controller', newDentist});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}