import pool from '../../config/db.js';

export default class Patient {
    constructor(id, firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, referrer, reason, totalBalance) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.middleName = middleName;
        this.birthDate = birthDate;
        this.age = age;
        this.sex = sex;
        this.nickname = nickname;
        this.nationality = nationality;
        this.religion = religion;
        this.occupation = occupation;
        this.referrer = referrer;
        this.reason = reason;
        this.totalBalance = totalBalance;
    }

    static async createPatient(data) {
        const { firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, referrer, reason, totalBalance } = data;

        const queryStr = 'INSERT INTO patients (patient_firstName, patient_lastName, patient_middleName, patient_birthDate, patient_age, patient_sex, patient_nickname, patient_nationality, patient_religion, patient_occupation, patient_referrer, patient_reason, patient_totalBal) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, referrer, reason, totalBalance];
        
        // execute
        try {
            // console.log('transaction:', transaction);
            const [result] = await pool.query(queryStr, values);
            const newPatient = result.insertId;
            if (newPatient) {
                console.log('Patient created successfully from model', newPatient);
                return newPatient;
            } else {
                throw new Error('Error creating patient');
            }
        } catch (error) {
            console.log('Error creating patient from model', error);
            throw error;
        }
    }

    static async getPatients() {
        const queryStr = 'SELECT * FROM patients';

        try {
            const [patients] = await pool.query(queryStr);
            return patients;
        } catch (error) {
            console.log('Error getting patients from model', error);
            throw error;
        }
    }

    static async getPatientByName(data) {
        const {firstName, lastName} = data;

        const queryStr = 'SELECT * FROM patients WHERE patient_firstName = ?';
        const values = [firstName, lastName];

        const [searchedPatients] = await pool.query(queryStr, values);
        return searchedPatients;
    } 

    static async getPatientById(id) {
        const queryStr = 'SELECT * FROM patients WHERE patient_id = ?';
        try {
            const [patient] = await pool.query(queryStr, [id]);
            if (patient.length === 0) {
                throw new Error('Patient data not found');
            } else {
                return patient;
            }
            
        } catch (error) {
            console.log('Error getting patient from model', error);
            throw error;
        }
    }

    static async getAllPatients() {
        const queryStr = 'SELECT * FROM patients';
        try {
            const [patients] = await pool.query(queryStr);
            return patients;
        } catch (error) {
            console.log('Error getting patients from model', error);
            throw error;
        }
    }

    // UPDATE

    static async updatePatient(data) {
        const { firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance, patient_id } = data;

        const queryStr = `
        UPDATE patients
        SET 
            patient_firstName = ?,
            patient_lastName = ?,
            patient_middleName = ?,
            patient_birthDate = ?,
            patient_age = ?,
            patient_sex = ?,
            patient_nickname = ?,
            patient_nationality = ?,
            patient_religion = ?,
            patient_occupation = ?,
            patient_reason = ?,
            patient_totalBal = ?
        WHERE patient_id = ?`;

    const values = [firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance, patient_id];
        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('no updates in patient, does not exist');
                throw new Error('Patient does not exist, ');
            }

            console.log('Patient updated successfully from model');
            return {
                affectedRows: result.affectedRows,
                message: 'Patient updated successfully',
                patient_id: patient_id
            }
        } catch (error) {
            console.log('Error updating patient from model', error);
            throw error;
        }
    }

    static async deletePatient(id) {
        try {
            const queryStr = 'DELETE FROM patients WHERE patient_id = ?';
            const [result] = await pool.query(queryStr, id);

            if (result.affectedRows === 0) {
                throw new Error('Patient not deleted, might not exist');
            } else {
                return {
                    message: 'Patient deleted successfully',
                    affectedRows: result.affectedRows,
                    patient_id: id
                }
            }
        } catch (error) {
            console.log('Error deleting patient from model', error);
            throw error;
        }
    }
}