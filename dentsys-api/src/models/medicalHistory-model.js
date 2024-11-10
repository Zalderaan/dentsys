import pool from '../../config/db.js';

export default class MedicalHistory {
    constructor(patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
        medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
        medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_isPregnant, medical_isNursing, medical_isBirthControl
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
        this.medical_isPregnant = medical_isPregnant;
        this.medical_isNursing = medical_isNursing;
        this.medical_isBirthControl = medical_isBirthControl;   
    }

    static async createMedicalHistory(data, { transaction }) {
        
        // extract data
        const { patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_isPregnant, medical_isNursing, medical_isBirthControl } = data;
        
        const queryStr = 'INSERT INTO medical_history (patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_isPregnant, medical_isNursing, medical_isBirthControl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [patient_id, medical_physician, medical_physicianSpec, medical_officeAddress, medical_officeNo, medical_goodHealth, medical_isUnderTreatment, 
            medical_treatmentDetails, medical_seriousOperation, medical_seriousOperationDetails, medical_hospitalized, medical_hospitalizedDetails, medical_isMedication, 
            medical_medicationDetails, medical_isTobacco, medical_dangerousSubstance, medical_bleedingTime, medical_isPregnant, medical_isNursing, medical_isBirthControl];

        try {
            const [medical_result] = await transaction.query(queryStr, values);
            const newMH = medical_result.insertId;
            console.log ('newMH:', newMH);
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
            throw new Error('Error creating medical history', error);
        }
    }
}