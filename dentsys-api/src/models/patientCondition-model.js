import pool from '../../config/db.js';

export default class PatientCondition {
    constructor(patient_id, condition_id, patientCondition_status) {
        this.patient_id = patient_id;
        this.condition_id = condition_id;
        this.patientCondition_status = patientCondition_status;
    }

    static async upsertPatientConditions(data) {
        const {patient_id, conditions} = data;
        const insertedConditions = [];
        const connection = await pool.getConnection();
        await connection.beginTransaction();
        try {
            // get current conditions of patient
            const currentConditions = await this.getPatientConditions(patient_id) || []; // NOTE: '|| []' is just a fallback to prevent 'undefined' error
            console.log('currentConditions:', currentConditions);

            // create a map of existing conditions
            const currentConditionsMap = new Map(currentConditions.map(condition => [condition.condition_id, condition]));

            for (const condition of conditions) {
                const {condition_id, patientCondition_status} = condition;
                
                if (currentConditionsMap.has(condition_id)) {
                    const queryStr = `
                        UPDATE patient_conditions
                        SET
                        patientCondition_status = ?
                        WHERE
                        patient_id = ? AND condition_id = ?;
                    `;
                    const values = [patientCondition_status, patient_id, condition_id];
                    const [condition_result] = await connection.query(queryStr, values);
                    insertedConditions.push(
                        {
                            patient_id: patient_id,
                            condition_id: condition_id,
                            patientCondition_status: patientCondition_status,
                            status: 'updated'
                        }
                    );
                } else {
                    const queryStr = 'INSERT INTO patient_conditions (patient_id, condition_id, patientCondition_status) VALUES (?, ?, ?)';
                    const values = [patient_id, condition_id, patientCondition_status];    
                    const [condition_result] = await connection.query(queryStr, values);
                    insertedConditions.push(
                        {
                            patient_id: patient_id,
                            condition_id: condition_id,
                            patientCondition_status: patientCondition_status,
                            status: 'inserted'
                        }
                    );
                }                
            }

            await connection.commit();
            if (insertedConditions.length === 0) {
                console.log('No conditions were added (either patient has no conditions or error');
                throw new Error('No conditions were added (either patient has no conditions or error');
            } else if (insertedConditions.length >= 1) {
                console.log('Patient conditions added successfully', insertedConditions);
            }
            return insertedConditions;
        } catch (error) {
            await connection.rollback();
            console.log('Error creating patient condition from model', error);
            throw error
        } finally {
            connection.release();
        }
    }

    static async getPatientConditions(patient_id) {
        const queryStr = 'SELECT * FROM patient_conditions WHERE patient_id = ?';

        try {
            const [conditions_result] = await pool.query(queryStr, [patient_id]); // a patient can have 0 to many medical conditions
            console.log('conditions_result:', conditions_result);
            return conditions_result || [];
        } catch (error) {
            console.log('Error getting patient conditions from model', error);
            throw error;  
        }
    }
}
