import pool from '../../config/db.js';

export default class Allergies {
    constructor(anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id){
        this.anesthetic = anesthetic;
        this.penicillin = penicillin;
        this.antibiotics = antibiotics;
        this.sulfaDrugs = sulfaDrugs;
        this.aspirin = aspirin;
        this.latex = latex;
        this.others = others;
        this.patient_id = patient_id;
    }

    static async createAllergies(data) {
        const {anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id} = data;

        const queryStr = 'INSERT INTO allergies (allergies_anesthetic, allergies_penicillin, allergies_antibiotics, allergies_sulfaDrugs, allergies_aspirin, allergies_latex, allergies_others, patient_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            const newAllergies = result.insertId;
            if (newAllergies) {
                console.log('Allergies created successfully from model', newAllergies);
                return newAllergies;
            } else {
                throw new Error('Error creating allergies');
            }
        } catch (error) {
            if(error.code === 'ER_DUP_ENTRY') {
                console.log('Allergies already exist');
                throw new Error('Allergies already exist');
            }
            console.log('Error creating allergies from model', error);
            throw error;
        }
    }

    static async getAllergies(id) {
        const queryStr = 'SELECT * FROM allergies WHERE patient_id = ?';

        try {
            const [allergies] = await pool.query(queryStr, [id]);
            
            if (allergies.length === 0) {
                throw new Error('Patient allergies not found');
            } else if (allergies.length > 1) {
                throw new Error('Multiple patient allergies found');
            }

            return allergies;
        } catch (error) {
            console.log('Error getting allergies from model', error);
            throw error;
        }
    }

    static async getByAllergiesId(id) {
        const queryStr = 'SELECT * FROM allergies WHERE allergies_id = ?';
        try {
            const [allergies] = await pool.query(queryStr, [id]);
            if (allergies.length === 0) {
                throw new Error('Allergies not found');
            } else if (allergies.length > 1) {
                throw new Error('Multiple allergies found');
            }
        } catch (error) {
            console.log('Error getting allergies by id from model', error);
            throw error;
        }
    }

    static async updateAllergies(data) {
        const {anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id} = data;
        const queryStr = 'UPDATE allergies SET allergies_anesthetic = ?, allergies_penicillin = ?, allergies_antibiotics = ?, allergies_sulfaDrugs = ?, allergies_aspirin = ?, allergies_latex = ?, allergies_others = ? WHERE patient_id = ?';
        const values = [anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('patient allergies does not exist, not updated');
                throw new Error('patient allergies does not exist, not updated');
            }
            console.log('Allergies updated successfully from model');
            return {
                affectedRows: result.affectedRows,
                message: 'Allergies updated successfully',
                patient_id: patient_id
            }
        } catch (error) {
            console.log('Error updating allergies from model', error);
            throw error;
        }   
    }

    static async deleteAllergies(id) {
        const queryStr = 'DELETE FROM allergies WHERE patient_id = ?';
        try {
            const [result] = await pool.query(queryStr, [id]);
            if (result.affectedRows === 0) {
                console.log('patient allergies might not exist, not deleted');
                throw new Error('patient allergies might not exist, not deleted');
            }

            return {
                affectedRows: result.affectedRows,
                message: 'Allergies deleted successfully',
                patient_id: id
            }
        } catch (error) {
            console.log ('Error deleting allergies from model', error);
            throw error;
        }
    }
}