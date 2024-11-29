const pool = require('../../config/db.js');
const bcrypt = require('bcryptjs');

class User {
    constructor(id, firstName, lastName, username, email, password) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    // helper functions
    static validateEmail(email) {
        const emailRegex = /\S+@\S+\.\S+/;
        if(!emailRegex.test(email)) {
            throw new Error('Invalid email format');
        }
        return emailRegex.test(email);
    }

    // methods for user model

    static async createUser(data) {
        // // Log the data for debugging
        // console.log('Received data:', data);

        // Extract data
        const { firstName, lastName, username, email, password } = data;
        
        // check if all fields are present
        if (!firstName || !lastName || !username || !email || !password) {
            throw new Error('All fields are required');
        }

        // validate email
        this.validateEmail(email);

        // validate username unique
        const usernameQuery = 'SELECT * FROM users WHERE user_username = ?';
        const [usernameResult] = await pool.query(usernameQuery, username);
        if (usernameResult.length > 0) {
            throw new Error('Username already exists check 1');
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(password, 10);

        // prepare statement
        const queryStr = 'INSERT INTO users (user_firstName, user_lastName, user_username, user_email, user_password) VALUES (?, ?, ?, ?, ?)';
        const values = [firstName, lastName, username, email, hashedPassword];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            const newUserId = result.insertId;
            const newUser = await this.getById(newUserId);
            if(newUser) {
                console.log('User created successfully from model', newUser);
                return newUser;
            } else {
                throw new Error('User not created');
            }
        } catch (error) {
            console.error('Error creating dentist', error);
            if (error.code === 'ER_DUP_ENTRY') {
                throw new Error('User already exists check 2');
            } else {
                throw error;
            }
        }
    }

    static async comparePassword(input_pass, db_pass) {
        // console.log('input_pass:', input_pass);
        // console.log('db_pass:', db_pass);

        const match = await bcrypt.compare(input_pass, db_pass);
        // console.log('match in model:', match);
        return match;
    }

    static async getByUsername(data) {
        // log data for debugging
        console.log('Received data:', data);

        // extract data
        const username = data.username;

        // validation
        if (!username) {
            throw new Error('Username is required for getByUsername');
        }

        // prepare query
        const queryStr = 'SELECT * FROM users WHERE user_username = ?';
        const values = [username];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            const user = result[0];
            if (result.length === 0) {
                throw new Error('User not found');
            } else {
                console.log('User found successfully from model', result); // for debugging
                return user;
            }
        } catch (error) {
            console.error('Error getting user', error);
            throw error;
        }
    }

    static async getById(data) {
        console.log('Received data:', data); // log data for debugging
        
        // extract data
        const id = data;

        // validate
        if (!id) {
            throw new Error('ID is required for getById');
        }

        // prepare query
        const queryStr = 'SELECT * FROM users WHERE user_id = ?';
        const values = [id];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            const user = result[0];
            if (result.length === 0) {
                throw new Error('User not found by id');
            } else {
                console.log('User found by id successfully from model', result);
                return user;
            }
        } catch (error) {
            console.error('Error getting user by id', error);
            throw error;
        }
    }
    
    static async updateUser(data) {
        // log data for debugging
        console.log('Received data:', data);

        // extract data
        const { id, firstName, lastName, username, email } = data;

        // validate
        if (!id) {
            throw new Error('ID is required for updateUser');
        }

        // prepare query
        const queryStr = 'UPDATE users SET user_firstName = ?, user_lastName = ?, user_username = ?, user_email = ? WHERE user_id = ?';
        const values = [firstName, lastName, username, email, id];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                throw new Error('User not found to update');
            } else {
                console.log('User updated successfully from model', result.affectedRows);
                return result.affectedRows;
            }
        } catch (error) {
            console.error('Error updating user', error);
            throw error;
        }
    }

    static async deleteUser(data) {
        // log data for debuggin
        console.log('Received data:', data);
        
        // extract data
        const id = data.id;

        // validate
        if (!id) {
            throw new Error('ID is required for deleteUser');
        }

        // prepare query
        queryStr = 'DELETE FROM users WHERE user_id = ?';
        values = [id];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                throw new Error('User not found to delete');
            } else {
                console.log('User deleted successfully from model', result.affectedRows);
                return result.affectedRows;
            }
        } catch (error) {
            console.error('Error deleting user', error);
            throw error;
        }
    }
}

module.exports = User;