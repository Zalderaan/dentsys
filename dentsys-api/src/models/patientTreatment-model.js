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
        // console.log('patient_id:', patient_id);
        try {
            const queryStr = 'SELECT * FROM patient_treatments WHERE patient_id = ?';
            const [result] = await pool.query(queryStr, patient_id);
            return result;
        } catch (error) {
            console.error('Error in getTrByPatient model:', error);
            throw error;
        }
    }

    static async getPatientLastBalance(patient_id) {
        try {
            const queryStr = 'SELECT treatment_balance FROM patient_treatments WHERE patient_id = ? ORDER BY treatment_id DESC LIMIT 1';
            const [result] = await pool.query(queryStr, patient_id);
            if(result.length === 0) {
                return 0.0;
            } else {
                return result[0].treatment_balance;
            }
        } catch (error) {
            console.error('Error in getPatientLastTreatmentBalance model:', error);
            throw error;
        }
    }

    static async getBalanceBeforeTreatment(patient_id, treatment_id) {
        try {
            const queryStr = `
                SELECT treatment_balance 
                FROM patient_treatments 
                WHERE patient_id = ? AND treatment_id < ?
                ORDER BY treatment_id DESC 
                LIMIT 1
            `;
            const values = [patient_id, treatment_id];
            const [result] = await pool.query(queryStr, values);
            return result.length > 0 ? result[0].treatment_balance : 0.0;
        } catch (error) {
            console.error('Error in getBalanceBeforeTreatment model:', error);
            throw error;
        }
    }

    static async updatePatientTreatment(data) {
        console.log('data in model: ', data);
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

    static async deletePatientTreatment(data) {
        try {
            const treatment_id = data;
            console.log ('treatment_id:', treatment_id);
            const queryStr = 'DELETE FROM patient_treatments WHERE treatment_id = ?';
            const [result] = await pool.query(queryStr, treatment_id);
            if (result.affectedRows > 0) {
                console.log('Patient treatment deleted:', treatment_id);
                return {
                    message: 'Patient treatment deleted',
                    treatment_id: treatment_id
                };
            } else {
                throw new Error('Failed to delete patient treatment');
            }
        } catch (error) {
            console.error('Error in delete patientTr model:', error);
            throw error;
        }
    }
}