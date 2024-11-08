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

    static async createAllergies(data, { transaction }) {
        const {anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id} = data;

        const queryStr = 'INSERT INTO allergies (allergies_anesthetic, allergies_penicillin, allergies_antibiotics, allergies_sulfaDrugs, allergies_aspirin, allergies_latex, allergies_others, patient_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [anesthetic, penicillin, antibiotics, sulfaDrugs, aspirin, latex, others, patient_id];

        try {
            const [result] = await transaction.query(queryStr, values);
            const newAllergies = result.insertId;
            if (newAllergies) {
                console.log('Allergies created successfully from model', newAllergies);
                return newAllergies;
            } else {
                throw new Error('Error creating allergies');
            }
        } catch (error) {
            console.log('Error creating allergies from model', error);
            throw new Error ('Error creating allergies', error);
        }
    }

    static async getAllergies(id){
        const queryStr = 'SELECT * FROM allergies WHERE patient_id = ?';

        try {
            const [allergies] = await pool.query(queryStr, [id]);

            if (!allergies) {
                throw new Error('Patient allergies not found');
            }

            return allergies;
        } catch (error) {
            console.log('Error getting allergies from model', error);
            throw new Error ('Error getting allergies', error);
        }
    }
}