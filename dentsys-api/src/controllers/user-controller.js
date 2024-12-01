const User = require('../models/user-model');

class UserController {
    // POST
    static async registerUser(req, res) {
        const data = req.body;
        try {
            const newUser = await User.createUser(data);
            return res.status(201).json({ message: 'User created successfully from controller', user: newUser});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async loginUser(req, res) {        
        try {
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
                return res.status(200).json({ message: 'Login successful', user });
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // update user
    static async updateUser(req, res) {
        const data = req.body;

        const user = await User.getById(data);

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        try {
            const updatedUser = await User.updateUser(data);
            return res.status(200).json({ message: 'User updated successfully from controller', updatedUser });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = UserController;