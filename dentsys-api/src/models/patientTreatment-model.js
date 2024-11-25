import pool from '../../config/db.js';

export default class PatientTreatment {
    static async createPatientTreatment(data) {
        try {
            const {patient_id, treatment_prcdName, treatment_date, treatment_toothNo, treatment_dentist, treatment_charged, treatment_paid, treatment_balance} = data;
            const queryStr = 'INSERT INTO patient_treatments (patient_id, treatment_prcdName, treatment_date, treatment_toothNo, treatment_dentist, treatment_charged, treatment_paid, treatment_balance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
            const values = [patient_id, treatment_prcdName, treatment_date, treatment_toothNo, treatment_dentist, treatment_charged, treatment_paid, treatment_balance];
            const [result] = await pool.query(queryStr, values);
            const newTreatmentId = result.insertId;
            const newTreatment = await this.getPatientTreatmentById(newTreatmentId);
            if (newTreatment) {
                console.log('New patient treatment created:', newTreatment);
                return newTreatment;
            } else {
                throw new Error('Failed to create new patient treatment');
            }
        } catch (error) {
            console.error('Error in create patientTr model:', error);
            throw error;
        }
    }

    static async getPatientTreatmentById(treatment_id) {
        try {
            const queryStr = 'SELECT * FROM patient_treatments WHERE treatment_id = ?';
            const [result] = await pool.query(queryStr, treatment_id);
            return result[0];
        } catch (error) {
            console.error('Error in get patientTr model:', error);
        }
    }

    static async getTrByPatientID(patient_id) {
        try {
            const queryStr = 'SELECT * FROM patient_treatments WHERE patient_id = ?';
            const [result] = await pool.query(queryStr, patient_id);
            return result;
        } catch (error) {
            console.error('Error in getTrByPatient model:', error);
            throw error;
        }
    }

    static async updatePatientTreatment(data) {
        try {
            const {treatment_id, treatment_prcdName, treatment_date, treatment_toothNo, treatment_charged, treatment_paid, treatment_balance} = data;
            const queryStr = `
                UPDATE patient_treatments
                SET
                treatment_prcdName = ?,
                treatment_date = ?,
                treatment_toothNo = ?,
                treatment_charged = ?,
                treatment_paid = ?,
                treatment_balance = ?
                WHERE
                treatment_id = ?;
            `;
            const values = [treatment_prcdName, treatment_date, treatment_toothNo, treatment_charged, treatment_paid, treatment_balance, treatment_id];
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows > 0) {
                const updatedTreatment = await this.getPatientTreatmentById(treatment_id);
                console.log('Patient treatment updated:', updatedTreatment);
                return updatedTreatment;
            } else {
                throw new Error('Failed to update patient treatment');
            }
        } catch (error) {
            console.error('Error in update patientTr model:', error);
            throw error;
        }
    }

    static async deletePatientCondition(data) {
        try {

        } catch (error) {
            console.error('Error in delete patientTr model:', error);
            throw error;
        }
    }
}