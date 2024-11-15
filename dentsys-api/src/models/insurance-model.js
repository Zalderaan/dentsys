import pool from '../../config/db.js';

export default class Insurance {
    constructor(insurance_name, effective_date, patient_id){
        this.insurance_name = insurance_name;
        this.effective_date = effective_date;
        this.patient_id = patient_id;
    }

    static async createInsurance(data) {
        const {insurance_name, effective_date, patient_id} = data;

        const queryStr = 'INSERT INTO insurance (insurance_name, effective_date, patient_id) VALUES (?, ?, ?)';
        const values = [insurance_name, effective_date, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            const newInsurance = result.insertId;
            if (newInsurance) {
                console.log('Insurance created successfully from model', newInsurance);
                return newInsurance;
            } else {
                throw new Error('Error creating insurance');
            }
        } catch (error) {
            console.log('Error creating insurance from model', error);
            throw error;
        }
    }

    static async getInsurance(id){
        const queryStr = 'SELECT * FROM insurance WHERE patient_id = ?';
        try {
            const [insurance] = await pool.query(queryStr, [id]);
            
            if (insurance.length === 0) {
                throw new Error('Patient insurance not found');
            }
            return insurance;
        } catch (error) {
            console.log('Error getting insurance from model', error);
            throw error;
        }
    }

    static async getByInsuranceId(id){
        const queryStr = 'SELECT * FROM insurance WHERE insurance_id = ?';
        try {
            const [insurance] = await pool.query(queryStr, [id]);
            
            if (insurance.length === 0) {
                throw new Error('Patient insurance not found');
            }
            return insurance;
        } catch (error) {
            console.log('Error getting insurance from model', error);
            throw error;
        }
    }

    static async updateInsurance(data) {
        const {insurance_name, effective_date, patient_id} = data;
        const queryStr = 'UPDATE insurance SET insurance_name = ?, effective_date = ? WHERE patient_id = ?';
        const values = [insurance_name, effective_date, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('no updates in Insurance, does not exist');
                throw new Error('Insurance not updated, does not exist');
            } else {
                console.log('Insurance updated successfully from model');
                return {
                    affectedRows: result.affectedRows,
                    message: 'Insurance updated successfully',
                    patient_id: patient_id
                }
            }
        } catch (error) {
            console.log('Error updating insurance from model', error);
            throw error;
        }
    }

    static async deleteInsurance(id) {
        const queryStr = 'DELETE FROM insurance WHERE patient_id = ?';
        try {
            const [result] = await pool.query(queryStr, [id]);
            if (result.affectedRows === 0) {
                console.log('Insurance not deleted, does not exist');
                throw new Error('Insurance not deleted, does not exist');
            } else {
                console.log('Insurance deleted successfully from model');
                return {
                    affectedRows: result.affectedRows,
                    message: 'Insurance deleted successfully',
                    patient_id: id
                }
            }
        } catch (error) {
            console.log('Error deleting insurance from model', error);
            throw error;
        }
    }
}