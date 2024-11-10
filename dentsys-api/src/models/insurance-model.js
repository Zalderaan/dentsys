import pool from '../../config/db.js';

export default class Insurance {
    constructor(insurance_name, effective_date, patient_id){
        this.insurance_name = insurance_name;
        this.effective_date = effective_date;
        this.patient_id = patient_id;
    }

    static async createInsurance(data, { transaction }) {
        const {insurance_name, effective_date, patient_id} = data;

        const queryStr = 'INSERT INTO insurance (insurance_name, effective_date, patient_id) VALUES (?, ?, ?)';
        const values = [insurance_name, effective_date, patient_id];

        try {
            const [result] = await transaction.query(queryStr, values);
            const newInsurance = result.insertId;
            if (newInsurance) {
                console.log('Insurance created successfully from model', newInsurance);
                return newInsurance;
            } else {
                throw new Error('Error creating insurance');
            }
        } catch (error) {
            console.log('Error creating insurance from model', error);
            return { error: error.message };
        }
    }

    static async getInsurance(id, { connection }){
        const queryStr = 'SELECT * FROM insurance WHERE patient_id = ?';
        try {
            const [insurance] = await connection.query(queryStr, [id]);
            return insurance;

            if (!insurance) {
                throw new Error('Patient insurance not found');
            }
        } catch (error) {
            console.log('Error getting insurance from model', error);
            return { error: error.message };
        }
    }
}