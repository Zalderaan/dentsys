const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const config = require('../../config/backupConfig.json');

const ExcelJS = require('exceljs');
const Allergies = require('./allergies-model.js');
const Contact = require('./contact-model.js');
const DentalHistory = require('./dentalHistory-model.js');
const Insurance = require('./insurance-model.js');
const MedicalHistory = require('./medicalHistory-model.js');
const Patient = require('./patient-model.js');
const PatientCondition = require('./patientCondition-model.js');
const PatientTreatment = require('./patientTreatment-model.js');

class Backup {
    static async performBackup(customPath){
        console.log('customPath in model: ', customPath);
        try {
            // db creds
            const dbName = config.dbCredentials.database;
            const dbUser = config.dbCredentials.user;
            const dbPass = config.dbCredentials.password;

            // construct the backup command
            const dumpPath = 'C:/xampp/mysql/bin/mysqldump';
            const defaultSavePath = "C:/Program Files/DentSys/backups";
            const savePath = customPath || defaultSavePath;

            // // ensure the backup directory exists
            // if(!fs.existsSync(savePath)){
            //     fs.mkdirSync(savePath, {recursive: true});
            // }
            
            const dumpProcess = spawn(dumpPath, ['-u', dbUser, dbName], { stdio: ['ignore']});
            dumpProcess.stdout.pipe(fs.createWriteStream(savePath));

            dumpProcess.on('close', (code) => {
                if (code === 0) {
                    console.log('Backup successful! @ ', savePath);
                } else {
                    console.error(`Backup process exited with code ${code}`);
                }
            });
        } catch (error) {
            console.error('Error: ', error);
            throw error;
        }
    }

    static async restoreBackup(backupName){
        try {
            console.log('backupName in model: ', backupName);
            // db creds
            const dbName = config.dbCredentials.database;
            const dbUser = config.dbCredentials.user;
            const dbPass = config.dbCredentials.password;

            // construct the restore command
            const restorePath = 'C:/xampp/mysql/bin/mysql';
            const backupPath = backupName;

            const restoreProcess = spawn(restorePath, ['-u', dbUser, dbName], { stdio: ['pipe', 'pipe', 'pipe'] });
            const backupStream = fs.createReadStream(backupPath);

            backupStream.pipe(restoreProcess.stdin);

            restoreProcess.on('close', (code) => {
                if (code === 0) {
                    console.log('Restore successful!');
                } else {
                    console.error(`Restore process exited with code ${code}`);
                }
            });
        } catch (error) {
            console.error('Error: ', error);
            throw error;
        }
    }

    static async exportPatientData(){
        try {
            const patients = await Patient.getAllPatients();
            const contacts = await Contact.getAllContacts();
            const allergies = await Allergies.getAllAllergies();
            const dentalHistories = await DentalHistory.getAllDentalHist();
            const insurances = await Insurance.getAllInsurance();
            const medicalHistories = await MedicalHistory.getAllMedicalHistory();
            const patientConditions = await PatientCondition.getAllPatientConditions();
            const patientTreatments = await PatientTreatment.getAllTreatment();
            return {
                patients,
                contacts,
                allergies,
                dentalHistories,
                insurances,
                medicalHistories,
                patientConditions,
                patientTreatments
            }
        } catch (error) {
            console.error('Error: ', error);
            throw error;
        }
    }
}

module.exports = Backup;