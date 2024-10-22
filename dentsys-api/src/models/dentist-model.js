import pool from '../../config/db.js';
import bcrypt from 'bcrypt';

export default class Dentist {
    constructor(id, firstName, lastName, username, email, password) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    static async createDentist(data) {
        // Log the data for debugging
        console.log('Received data:', data);

        // Extract data
        const { firstName, lastName, username, email, password } = data;
        const hashedPassword = await bcrypt.hash(data.password, 10);

        // Ensure password exists in the request body
        if (!password) {
            throw new Error('Password is required');
        }

        // prepare statement
        const query_str = 'INSERT INTO dentists (dentist_firstName, dentist_lastName, dentist_username, dentist_email, dentist_password) VALUES (?, ?, ?, ?, ?)';
        const values = [firstName, lastName, username, email, hashedPassword];

        // execute
        try {
            const [result] = await pool.query(query_str, values);
            console.log('Dentist created successfully', result.insertId);
            return result.insertId;
        } catch (error) {
            console.error('Error creating dentist', error);
            throw new Error('db error: unable to create dentist');
        }
    }

}