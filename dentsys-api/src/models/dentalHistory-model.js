const pool = require('../../config/db.js');

class DentalHistory {
    constructor(previous_dentist, last_visit, patient_id){
        this.previous_dentist = previous_dentist;
        this.last_visit = last_visit;
        this.patient_id = patient_id;
    }

    static async createDentalHist(data) { 
        const {previous_dentist, last_visit, patient_id} = data;

        try {
            const queryStr = 'INSERT INTO dental_history (dental_previousDentist, dental_lastVisit, patient_id) VALUES (?, ?, ?)';
            const values = [previous_dentist, last_visit, patient_id];
            const [result] = await pool.query(queryStr, values);
            const newDentalHist = result.insertId;
            if (newDentalHist) {
                console.log('Dental history created successfully from model', newDentalHist);
                return newDentalHist;
            } else {
                throw new Error('Error creating dental history');
            }
        } catch (error) {
            console.log('Error creating dental history from model', error);
            throw error;
        }
    }

    static async getDentalHist(id) {
        try {
            const queryStr = 'SELECT * FROM dental_history WHERE patient_id = ?';
            const [dentalHist] = await pool.query(queryStr, [id]);
            if(dentalHist.length === 0) {
                throw new Error('dental history not found');
            } else {
                console.log('Dental history retrieved successfully from model');
                return dentalHist;
            }
        } catch (error) {
            console.log('Error getting dental history from model', error);
            throw error;
        }
    }

    static async getDentalHistByDentalId(id) {
        try {
            const queryStr = 'SELECT * FROM dental_history WHERE dental_id = ?';
            const [dentalHist] = await pool.query(queryStr, [id]);
            if(dentalHist.length === 0) {
                throw new Error('dental history not found');
            } else {
                console.log('Dental history retrieved successfully from model');
                return dentalHist;
            }
        } catch (error) {
            console.log('Error getting dental history from model', error);
            throw error;
        }
    }

    static async updateDentalHist(data) {
        const {previous_dentist, last_visit, patient_id} = data;
        const queryStr = 'UPDATE dental_history SET dental_previousDentist = ?, dental_lastVisit = ? WHERE patient_id = ?';
        const values = [previous_dentist, last_visit, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('Dental history not updated, does not exist');
                throw new Error('Dental history not updated, does not exist');
            } else {
                console.log('Dental history updated successfully from model');
                return {
                    affectedRows: result.affectedRows,
                    message: 'dental history updated successfully',
                    patient_id: patient_id
                }
            }
        } catch (error) {
            console.log('Error updating dental history from model', error);
            throw error;
        }
    }

    static async deleteDentalHist(id) {
        const queryStr = 'DELETE FROM dental_history WHERE patient_id = ?';
        try {
            const [result] = await pool.query(queryStr, [id]);
            if (result.affectedRows === 0) {
                console.log('Dental history does not exist, not deleted');
                throw new Error('Dental history does not exist, not deleted');
            } else {
                console.log('Dental history deleted successfully from model');
                return {
                    affectedRows: result.affectedRows,
                    message: 'Dental history deleted successfully',
                    patient_id: id
                }
            }
        } catch (error) {
            console.log('Error deleting dental history from model', error);
            throw error;
        }
    }
}

module.exports = DentalHistory;