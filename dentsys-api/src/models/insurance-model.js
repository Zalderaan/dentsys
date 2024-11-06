import pool from '../../config/db.js';

export default class Insurance {
    constructor(insurance_name, effective_date, patient_id){
        this.insurance_name = insurance_name;
        this.effective_date = effective_date;
        this.patient_id = patient_id;
    }

    static async createInsurance(data){
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
            throw new Error ('Error creating insurance', error);
        }
    }

    static async getInsurance(id){
        const queryStr = 'SELECT * FROM insurance WHERE patient_id = ?';
        try {
            const [insurance] = await pool.query(queryStr, [id]);
            return insurance;
        } catch (error) {
            console.log('Error getting insurance from model', error);
            throw new Error ('Error getting insurance', error);
        }
    }
}