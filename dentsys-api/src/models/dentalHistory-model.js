import pool from '../../config/db.js';

export default class DentalHistory {
    constructor(previous_dentist, last_visit, patient_id){
        this.previous_dentist = previous_dentist;
        this.last_visit = last_visit;
        this.patient_id = patient_id;
    }

    static async createDentalHist(data, { transaction }) { 
        const {previous_dentist, last_visit, patient_id} = data;

        try {
            const queryStr = 'INSERT INTO dental_history (dental_previousDentist, dental_lastVisit, patient_id) VALUES (?, ?, ?)';
            const values = [previous_dentist, last_visit, patient_id];
            const [result] = await transaction.query(queryStr, values);
            const newDentalHist = result.insertId;
            if (newDentalHist) {
                console.log('Dental history created successfully from model', newDentalHist);
                return newDentalHist;
            } else {
                throw new Error('Error creating dental history');
            }
        } catch (error) {
            console.log('Error creating dental history from model', error);
            return { error: error.message };
        }
    }

    static async getDentalHist(id, { connection }) {
        try {
            const queryStr = 'SELECT * FROM dental_history WHERE patient_id = ?';
            const [dentalHist] = await connection.query(queryStr, [id]);
            if(!dentalHist) {
                throw new Error('Error getting dental history');
            } else {
                console.log('Dental history retrieved successfully from model');
                return dentalHist;
            }
        } catch (error) {
            console.log('Error getting dental history from model', error);
            return { error: error.message };
        }
    }
}