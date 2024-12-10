const Backup = require('../models/backup-model');
const ExcelJS = require('exceljs');

class BackupController {
    static async backup(req, res) {
        try {
            const customPath = req.body.path;
            console.log('customPath in controller: ', customPath);
            await Backup.performBackup(customPath);
            return res.status(200).json({ message: 'Backup successful!' });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    static async restore(req, res) {
        try{
            const backupName = req.body.path;
            console.log('backupName in controller: ', backupName);
            await Backup.restoreBackup(backupName);
            return res.status(200).json({ message: 'Restore successful!' });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    static async exportPatientData(req, res) {
        try {
            const customSavePath = req.body.path;
            console.log('customSavePath in controller: ', customSavePath);
            const workbook = new ExcelJS.Workbook(); // create workbook
            const data = await Backup.exportPatientData(); // get data

            // Sheet 1: Patients
            const patientsSheet = workbook.addWorksheet('Patients');
            patientsSheet.columns = [
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'First Name', key: 'patient_firstName', width: 20 },
                { header: 'Middle Name', key: 'patient_middleName', width: 20 },
                { header: 'Last Name', key: 'patient_lastName', width: 20 },
                { header: 'Nickname' , key: 'patient_nickname', width: 20 },
                { header: 'Date of Birth', key: 'patient_birthdate', width: 20 },
                { header: 'Age', key: 'patient_age', width: 10 },
                { header: 'Sex', key: 'patient_sex', width: 10 },
                { header: 'Nationality', key: 'patient_nationality', width: 20 },
                { header: 'Religion', key: 'patient_religion', width: 20 },
                { header: 'Occupation', key: 'patient_occupation', width: 20 },
                { header: 'Referrered By', key: 'patient_referrer', width: 20 },
                { header: 'Reason for Consultation', key: 'patient_reason', width: 20 },
                { header: 'parent/guardian', key: 'patient_parentName', width: 20 },
                { header: 'parent/guardian occupation', key: 'patient_parentOccupation', width: 20 },
            ];
            patientsSheet.addRows(data.patients);

            // Sheet 2: Contact
            const contactSheet = workbook.addWorksheet('Contact');
            contactSheet.columns = [
                { header: 'Contact ID', key: 'contact_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Address', key: 'contact_homeAddress', width: 20 },
                { header: 'Home Phone', key: 'contact_homeNo', width: 20 },
                { header: 'Office Phone', key: 'contact_officeNo', width: 20 },
                { header: 'Mobile Phone', key: 'contact_mobileNo', width: 20 },
                { header: 'Fax No', key: 'contact_faxNo', width: 20 },
                { header: 'Email', key: 'contact_email', width: 20 },
            ];
            contactSheet.addRows(data.contacts);

            // Sheet 3: Dental History
            const dentalHistorySheet = workbook.addWorksheet('Dental History');
            dentalHistorySheet.columns = [
                { header: 'Dental History ID', key: 'dental_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Previous Dentist', key: 'dental_previousDentist', width: 20 },
                { header: 'Last Visit', key: 'dental_lastVisit', width: 20 },
            ];
            dentalHistorySheet.addRows(data.dentalHistories);

            // Sheet 4: Medical History
            const medicalHistorySheet = workbook.addWorksheet('Medical History');
            medicalHistorySheet.columns = [
                { header: 'Medical History ID', key: 'medical_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Physician', key: 'medical_physician', width: 20 },
                { header: 'Physician Specialty', key: 'medical_physicianSpec', width: 20 },
                { header: 'Physician Address', key: 'medical_officeAddress', width: 20 },
                { header: 'Physician Phone', key: 'medical_officeNo', width: 20 },
                { header: 'Is in Good Health', key: 'medical_goodHealth', width: 20 },
                { header: 'Under Treatment', key: 'medical_isUnderTreatment', width: 20 },
                { header: 'Treatment Details', key: 'medical_treatmentDetails', width: 20 },
                { header: 'Serious Operation', key: 'medical_seriousOperation', width: 20 },
                { header: 'Serious Operation Details', key: 'medical_operationDetails', width: 20 },
                { header: 'Hospitalized', key: 'medical_hospitalized', width: 20 },
                { header: 'Hospitalized Details', key: 'medical_hospitalizedDetails', width: 20 },
                { header: 'Under Medication', key: 'medical_isMedication', width: 20 },
                { header: 'Medication Details', key: 'medical_medicationDetails', width: 20 },
                { header: 'Uses Tobacco', key: 'medical_isTobacco', width: 20 },
                { header: 'Uses Alcohol/Dangerous Substance', key: 'medical_isDangerousSubstance', width: 20 },
                { header: 'Bleeding Time', key: 'medical_bleedingTime', width: 20 },
                { header: 'Blood Pressure', key: 'medical_bloodPressure', width: 20 },
                { header: 'BloodType', key: 'medical_bloodType', width: 20 },
                { header: 'isPregnant', key: 'medical_isPregnant', width: 20 },
                { header: 'isNursing', key: 'medical_isNursing', width: 20 },
                { header: 'isTakingBirthControl', key: 'medical_isTakingBirthControl', width: 20 }
            ];
            medicalHistorySheet.addRows(data.medicalHistories);

             // Sheet 5: Insurance
            const insuranceSheet = workbook.addWorksheet('Insurance');
            insuranceSheet.columns = [
                { header: 'Insurance ID', key: 'insurance_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Insurance Name', key: 'insurance_name', width: 20 },
                { header: 'Effective Date', key: 'effective_date', width: 20 },
            ];
            insuranceSheet.addRows(data.insurances);

            // sheet 6: Allergies
            const allergiesSheet = workbook.addWorksheet('Allergies');
            allergiesSheet.columns = [
                { header: 'Allergy ID', key: 'allergies_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Anesthetic', key: 'allergies_anesthetic', width: 20 },
                { header: 'Penicillin', key: 'allergies_penicillin', width: 20 },
                { header: 'Sulfa Drugs', key: 'allergies_sulfaDrugs', width: 20 },
                { header: 'Aspirin', key: 'allergies_aspirin', width: 20 },
                { header: 'Latex', key: 'allergies_latex', width: 20 },
                { header: 'Other', key: 'allergies_other', width: 20 },
            ];
            allergiesSheet.addRows(data.allergies);

            // Sheet 7: Patient Conditions
            const patientConditionsSheet = workbook.addWorksheet('Patient Conditions');
            patientConditionsSheet.columns = [
                { header: 'Patient Condition ID', key: 'patientCondition_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Condition ID', key: 'condition_id', width: 20 },
                { header: 'Condition Name', key: 'condition_name', width: 20 },
            ];
            patientConditionsSheet.addRows(data.patientConditions);

            // Sheet 8: Patient Treatments
            const patientTreatmentsSheet = workbook.addWorksheet('Patient Treatments');
            patientTreatmentsSheet.columns = [
                { header: 'Treatment ID', key: 'treatment_id', width: 10 },
                { header: 'Patient ID', key: 'patient_id', width: 10 },
                { header: 'Patient Name', key: 'patient_fullName', width: 20 },
                { header: 'Procedure Name', key: 'treatment_prcdName', width: 20 },
                { header: 'Tooth No', key: 'treatment_toothNo', width: 20 },
                { header: 'Charged', key: 'treatment_charged', width: 20 },
                { header: 'Paid', key: 'treatment_paid', width: 20 },
                { header: 'Balance', key: 'treatment_balance', width: 20 },
                { header: 'Date', key: 'treatment_date', width: 20 },
                { header: 'Dentist', key: 'treatment_dentist', width: 20 },
            ];
            patientTreatmentsSheet.addRows(data.patientTreatments);

            const dateTime = new Date().toISOString().replace(/:/g, '-');
            const filePath = `${customSavePath || 'C:/Program Files/DentSys'}/patientData_${dateTime}.xlsx`;
            await workbook.xlsx.writeFile(filePath);
            
            await new Promise((resolve, reject) => {
                res.download(filePath, 'patientData.xlsx', (err) => {
                    if (err) {
                        console.error('Error: ', err);
                        reject(err);
                    } else {
                        console.log('File sent successfully!');
                        resolve();
                    }
                });
            });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}

module.exports = BackupController;