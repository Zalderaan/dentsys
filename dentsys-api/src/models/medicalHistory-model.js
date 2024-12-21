const pool = require('../../config/db.js');
class MedicalHistory {
    constructor(patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
        medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
        medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl
    ){
        this.patient_id = patient_id;
        this.medical_physician = medical_physician;
        this.medical_physicianSpec = medical_physicianSpec;
        this.medical_officeAddress = medical_officeAddress;
        this.medical_officeNo = medical_officeNo;
        this.medical_goodHealth = medical_goodHealth;
        this.medical_isUnderTreatment = medical_isUnderTreatment;
        this.medical_treatmentDetails = medical_treatmentDetails;
        this.medical_seriousOperation = medical_seriousOperation;
        this.medical_seriousOperationDetails = medical_seriousOperationDetails;
        this.medical_hospitalized = medical_hospitalized;
        this.medical_hospitalizedDetails = medical_hospitalizedDetails;
        this.medical_isMedication = medical_isMedication;
        this.medical_medicationDetails = medical_medicationDetails;
        this.medical_isTobacco = medical_isTobacco;
        this.medical_dangerousSubstance = medical_dangerousSubstance;
        this.medical_bleedingTime = medical_bleedingTime;
        this.medical_bloodPressure = medical_bloodPressure;
        this.medical_bloodType = medical_bloodType;
        this.medical_isPregnant = medical_isPregnant;
        this.medical_isNursing = medical_isNursing;
        this.medical_isBirthControl = medical_isBirthControl;   
    }

    static async createMedicalHistory(data) {
        // console.log('data received in mh model:', data);
        // extract data
        const { patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl } = data;
        
        const queryStr = 
            `INSERT INTO medical_history (
                patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, medical_treatmentDetails, 
                medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, medical_medicationDetails, medical_isTobacco, 
                medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
        
        const values = [patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl];

        try {
            const [medical_result] = await pool.query(queryStr, values);
            const newMH = medical_result.insertId;
            // console.log ('newMH:', newMH);
            if (newMH) {
                console.log('Medical history created successfully from model', newMH);
                return newMH;
            } else {
                throw new Error('Error creating medical history');
            }
        } catch (error) {
            console.error('Error creating medical history from model:', error.message);
            // console.error('Query String:', queryStr);
            // console.error('Query Values:', values);
            throw error;
        }
    }

    static async getMedicalHistory(id, ) {
        const queryStr = 'SELECT * FROM medical_history WHERE patient_id = ?';
        try {
            const [mh_result] = await pool.query(queryStr, [id]);
            if (mh_result.length === 0) {
                throw new Error('Patient medical history not found');
            } else {
                // console.log('Medical history retrieved successfully from model');
                return mh_result;
            }
        } catch (error) {
            console.log('Error getting medical history from model', error);
            throw error;
        }
    }

    static async getByMedicalHistoryId(id) {
        const queryStr = 'SELECT * FROM medical_history WHERE medical_id = ?';
        try {
            const [mh_result] = await pool.query(queryStr, [id]);
            if (mh_result.length === 0) {
                throw new Error('Patient medical history not found');
            } else {
                // console.log('Medical history retrieved successfully from model');
                return mh_result;
            }
        } catch (error) {
            console.log('Error getting medical history from model', error);
            throw error;
        }
    }

    static async getAllMedicalHistory() {
        const queryStr = `
            SELECT mh.*, CONCAT(p.patient_firstName, ' ', patient_lastName) AS patient_fullName
            FROM medical_history mh
            JOIN patients p ON mh.patient_id = p.patient_id
        `;
        try {
            const [mh_result] = await pool.query(queryStr);
            if (mh_result.length === 0) {
                throw new Error('No medical history found');
            } else {
                console.log('All medical history retrieved successfully from model');
                return mh_result;
            }
        } catch (error) {
            console.log('Error getting all medical history from model', error);
            throw error;
        }
    }

    static async updateMedicalHistory(data) {
        console.log('data received in mh model:', data);
        const { medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl, patient_id } = data;

        const queryStr = `
            UPDATE medical_history 
            SET
                medical_physician = ?, 
                medical_physicianSpec = ?, 
                medical_officeAddress = ?, 
                medical_officeNo = ?, 
                medical_goodHealth = ?, 
                medical_isUnderTreatment = ?, 
                medical_treatmentDetails = ?, 
                medical_seriousOperation = ?, 
                medical_seriousOperationDetails = ?, 
                medical_hospitalized = ?, 
                medical_hospitalizedDetails = ?, 
                medical_isMedication = ?, 
                medical_medicationDetails = ?, 
                medical_isTobacco = ?, 
                medical_dangerousSubstance = ?, 
                medical_bleedingTime = ?, 
                medical_bloodPressure = ?,
                medical_bloodType = ?,
                medical_isPregnant = ?, 
                medical_isNursing = ?, 
                medical_isBirthControl = ?
            WHERE patient_id = ?`;

        const values = [medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_bloodPressure, medical_bloodType, medical_isPregnant, medical_isNursing, medical_isBirthControl, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('no updates made in med history, does not exist');
                throw new Error('Medical history not updated, does not exist');
            }
            
            console.log('Medical history updated successfully from model');
            return {
                affectedRows: result.affectedRows,
                message: 'Medical history updated successfully',
                patient_id: patient_id
            }
        } catch (error) {
            console.error('Error updating medical history from model', error);
            throw error;
        }
    }

    static async deleteMedicalHistory(id) {
        const queryStr = 'DELETE FROM medical_history WHERE patient_id = ?';
        try {
            const [result] = await pool.query(queryStr, [id]);
            if (result.affectedRows === 0) {
                console.log('Medical history not deleted, does not exist');
                throw new Error('Medical history not deleted, does not exist');
            } else {   
                return {
                    affectedRows: result.affectedRows,
                    message: 'Medical history deleted successfully from model',
                    patient_id: id
                }
            }
        } catch (error) {
            console.error('Error deleting medical history from model', error);
            throw error;
        }
    }
}

module.exports = MedicalHistory;