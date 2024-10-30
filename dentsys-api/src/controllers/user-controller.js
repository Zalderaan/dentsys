import User from '../models/user-model.js';
import { body, validationResult } from 'express-validator';
import bcrypt, { hash } from 'bcrypt';

export default class UserController {
    // POST
    static async registerUser(req, res) {
        const data = req.body;
        try {
            const newUser = await User.createUser(data);
            res.status(201).json({ message: 'User created successfully from controller', newUser});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async loginUser(req, res) {        
        const data = req.body;
        
        // get the user
        const user = await User.getByUsername(data);

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // compare password
        const match = await User.comparePassword(data.password, user.user_password);
        // console.log('match:', match);

        if (!match) {
            return res.status(401).json({ error: 'Invalid password' });
        } else {
            return res.status(200).json({ message: 'Login successful' });
        }
    }
}