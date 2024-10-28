import pool from '../../config/db.js';
import bcrypt from 'bcrypt';

export default class User {
    constructor(id, firstName, lastName, username, email, password) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = username;
        this.password = password;
    }

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
        const emailRegex = /\S+@\S+\.\S+/;
        if (!emailRegex.test(email)) {
            throw new Error('Invalid email format');
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(data.password, 10);

        // Ensure password exists in the request body
        if (!password) {
            throw new Error('Password is required');
        }

        // prepare statement
        const queryStr = 'INSERT INTO users (user_firstName, user_lastName, user_username, user_email, user_password) VALUES (?, ?, ?, ?, ?)';
        const values = [firstName, lastName, username, email, hashedPassword];

        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            console.log('User created successfully from model', result.insertId);
            return result.insertId;
        } catch (error) {
            console.error('Error creating dentist', error);
            throw new Error('db error: unable to create user');
        }
    }
}