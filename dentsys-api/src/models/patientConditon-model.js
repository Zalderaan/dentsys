import pool from '../../config/db.js';

export default class patientCondition {
    constructor(patient_id, condition_id, patientCondition_status) {
        this.patient_id = patient_id;
        this.condition_id = condition_id;
        this.patientCondition_status = patientCondition_status;
    }

    static async addPatientConditions(data, { transaction }) {
        const {patient_id, conditions} = data;

        // setup transaction
        // const connection = await pool.getConnection();

        const insertedConditions = [];
        try {
            // await connection.beginTransaction();
            for (const condition of conditions) {
                const {condition_id, patientCondition_status} = condition;
    
                const queryStr = 'INSERT INTO patient_conditions (patient_id, condition_id, patientCondition_status) VALUES (?, ?, ?)';
                const values = [patient_id, condition_id, patientCondition_status];
    
                const [condition_result] = await transaction.query(queryStr, values);
                if (!condition_result) {
                    throw new Error('Error creating patient condition');
                }

                insertedConditions.push(
                    {
                        patient_id: patient_id,
                        condition_id: condition_id,
                        patientCondition_status: patientCondition_status
                    }
                );
            }
            // await connection.commit();
            if (insertedConditions.length === 0) {
                throw new Error('Error creating patient condition');
            } else {
                console.log('Condition added successfully');
                return insertedConditions;
            } 
        } catch (error) {
            // await connection.rollback();
            console.log('Error creating patient condition from model', error);
            throw new Error ('Error creating patient condition', error);
        } finally {
            // connection.release();
        }
    }
}

