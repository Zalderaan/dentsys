import pool from '../../config/db.js';

export default class Patient {
    constructor(id, firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance) {
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
        this.reason = reason;
        this.totalBalance = totalBalance;
    }

    static async createPatient(data) {
        const { firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance } = data;

        const queryStr = 'INSERT INTO patients (patient_firstName, patient_lastName, patient_middleName, patient_birthDate, patient_age, patient_sex, patient_nickname, patient_nationality, patient_religion, patient_occupation, patient_reason, patient_totalBal) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance];

        // execute
        try {
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
            throw new Error ('Error creating patient');
        }
    }

    static async getPatients() {
        const queryStr = 'SELECT * FROM patients';
        const [patients] = await pool.query(queryStr);
        return patients;
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
        const [patient] = await pool.query(queryStr, id);
        return patient;
    }

    static async updatePatient(data) {
        const { firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance } = data;

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

    const values = [firstName, lastName, middleName, birthDate, age, sex, nickname, nationality, religion, occupation, reason, totalBalance, patientId];
        // execute
        try {
            const [result] = await pool.query(queryStr, values);
            const updPatient = result.insertId;
            if (updPatient) {
                console.log('Patient updated successfully from model', updPatient);
                return updPatient;
            } else {
                throw new Error('Error updating patient');
            }
        } catch (error) {
            console.log('Error updating patient from model', error);
            throw new Error ('Error updating patient');
        }
    }

    static async deletePatient(id) {
        const queryStr = 'DELETE FROM patients WHERE patient_id = ?';
        const [result] = await pool.query(queryStr, id);
        return result;
    }
}