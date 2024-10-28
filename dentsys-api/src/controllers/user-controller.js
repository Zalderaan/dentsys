import User from '../models/user-model.js';

export default class UserController {
    static async registerUser(req, res) {
        try {
            const newUser = await User.createUser(req.body);
            res.status(201).json({ message: 'User created successfully from controller', newUser});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}