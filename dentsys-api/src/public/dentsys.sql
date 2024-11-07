CREATE DATABASE IF NOT EXISTS dentsys;
USE dentsys;

-- USER TABLE
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_firstName VARCHAR(50) NOT NULL,
    user_lastName VARCHAR(50) NOT NULL,
    user_username VARCHAR(50) UNIQUE NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    user_password VARCHAR(255) NOT NULL
);

-- PATIENT TABLE
CREATE TABLE IF NOT EXISTS patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_firstName VARCHAR(50) NOT NULL,
    patient_lastName VARCHAR(50) NOT NULL,
    patient_middleName VARCHAR(50),
    patient_nickname VARCHAR(50) NOT NULL,
    patient_birthdate DATE,
    patient_age INT NOT NULL,
    patient_sex VARCHAR(50) NOT NULL,
    patient_nationality VARCHAR(50) NOT NULL,
    patient_religion VARCHAR(50) NOT NULL,
    patient_occupation VARCHAR(50) NOT NULL,
    patient_reason VARCHAR(100) NOT NULL, -- Increased size from 50 to 100
    patient_totalBal FLOAT NOT NULL, -- Changed to FLOAT for balance
    patient_parentName VARCHAR(50) NOT NULL,
    patient_parentOccupation VARCHAR(50) NOT NULL
);

-- CONTACT TABLE
CREATE TABLE IF NOT EXISTS contact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    contact_homeAddress VARCHAR(100) NOT NULL, -- Increased size from 50 to 100
    contact_homeNo VARCHAR(50) NOT NULL,
    contact_workNo VARCHAR(50) NOT NULL, 
    contact_mobileNo VARCHAR(50) NOT NULL,
    contact_faxNo VARCHAR(50) NOT NULL,
    contact_email VARCHAR(100) NOT NULL, -- Increased size from 50 to 100

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE -- Applied cascading actions
);

-- MEDICAL HISTORY TABLE
CREATE TABLE IF NOT EXISTS medical_history (
    medical_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    medical_physician VARCHAR(50) NOT NULL,
    medical_physicianSpec VARCHAR(50) NOT NULL,
    medical_officeAddress VARCHAR(100) NOT NULL,
    medical_officeNo VARCHAR(15) NOT NULL,
    medical_goodHealth BOOLEAN NOT NULL,
    medical_isUnderTreatment BOOLEAN NOT NULL,
    medical_treatmentDetails VARCHAR(255) NOT NULL,
    medical_seriousOperation BOOLEAN NOT NULL,
    medical_seriousOperationDetails VARCHAR(255) NOT NULL,
    medical_hospitalized BOOLEAN NOT NULL,
    medical_hospitalizedDetails VARCHAR(255) NOT NULL,
    medical_isMedication BOOLEAN NOT NULL,
    medical_medicationDetails VARCHAR(255) NOT NULL,
    medical_isTobacco BOOLEAN NOT NULL,
    medical_dangerousSubstance BOOLEAN NOT NULL,
    medical_bleedingTime INT,
    medical_isPregnant BOOLEAN NOT NULL,
    medical_isNursing BOOLEAN NOT NULL,
    medical_isBirthControl BOOLEAN NOT NULL,

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE -- Applied cascading actions
);

-- ALLERGIES TABLE
CREATE TABLE IF NOT EXISTS allergies (
    allergies_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    allergies_anesthetic BOOLEAN NOT NULL,
    allergies_penicillin BOOLEAN NOT NULL,
    allergies_antibiotics BOOLEAN NOT NULL,
    allergies_sulfaDrugs BOOLEAN NOT NULL,
    allergies_aspirin BOOLEAN NOT NULL,
    allergies_latex BOOLEAN NOT NULL,
    allergies_others TEXT,

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE -- Applied cascading actions
);

-- PRICING TYPES TABLE
CREATE TABLE IF NOT EXISTS pricing_types (
    prType_id INT AUTO_INCREMENT PRIMARY KEY,
    prType_name VARCHAR(50) NOT NULL
);

-- PROCEDURES TABLE
CREATE TABLE IF NOT EXISTS procedures (
    prcd_id INT AUTO_INCREMENT PRIMARY KEY,
    prType_id INT NOT NULL,
    prcd_name VARCHAR(50) NOT NULL,
    prcd_description VARCHAR(50) NOT NULL,
    prcd_category VARCHAR(50) NOT NULL,
    prcd_price FLOAT NOT NULL, -- Changed to FLOAT for price
    prcd_minPrice INT NOT NULL,
    prcd_maxPrice INT NOT NULL,
    FOREIGN KEY (prType_id) REFERENCES pricing_types(prType_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS treatment_record (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    user_id INT NOT NULL,
    prcd_id INT NOT NULL,
    treatment_date DATE NOT NULL,
    treatment_toothNo VARCHAR(50) NOT NULL,
    treatment_amountCharged FLOAT NOT NULL,
    treatment_amountPaid FLOAT NOT NULL,
    treatment_balance FLOAT NOT NULL,
    treatment_discount FLOAT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prcd_id) REFERENCES procedures(prcd_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    insurance_name VARCHAR(50) NOT NULL,
    effective_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS dental_history (
    dental_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    dental_previousDentist VARCHAR(50) NOT NULL,
    dental_lastVisit DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREATE TABLE IF NOT EXISTS health_condition (  
--     condition_id INT AUTO_INCREMENT PRIMARY KEY,
--     patient_id INT NOT NULL UNIQUE,
--     condition_highBlood BOOLEAN NOT NULL,
--     condition_lowBlood BOOLEAN NOT NULL,
--     condition_epliepsy BOOLEAN NOT NULL,
--     condition_aids BOOLEAN NOT NULL,
--     condition_std BOOLEAN NOT NULL,
--     condition_stomachUlcer BOOLEAN NOT NULL,
--     condition_faintingSeizures BOOLEAN NOT NULL,
--     condition_rapidWeightLoss BOOLEAN NOT NULL,
--     condition_radTherapy BOOLEAN NOT NULL,
--     condition_jointReplacement BOOLEAN NOT NULL,
--     condition_heartSurgery BOOLEAN NOT NULL,
--     condition_heartAttack BOOLEAN NOT NULL,
--     condition_heartDisease BOOLEAN NOT NULL,
--     conition_heartMurmur BOOLEAN NOT NULL,
--     condition_thyroid BOOLEAN NOT NULL,
--     condition_hepatitisLiver BOOLEAN NOT NULL,
--     condition_jaundice BOOLEAN NOT NULL,
--     condition_rheumaticFever BOOLEAN NOT NULL,
--     condition_hayFever BOOLEAN NOT NULL,
--     condition_respiratoryProblems BOOLEAN NOT NULL,
--     condition_tuberculosis BOOLEAN NOT NULL,
--     condition_swollenAnkles BOOLEAN NOT NULL,
--     condition_kidneyDisease BOOLEAN NOT NULL,
--     condition_diabetes BOOLEAN NOT NULL,
--     condition_chestPain BOOLEAN NOT NULL,
--     condition_stroke BOOLEAN NOT NULL,
--     condition_tumors BOOLEAN NOT NULL,
--     condition_anemia BOOLEAN NOT NULL,
--     condition_angina BOOLEAN NOT NULL,
--     condition_asthma BOOLEAN NOT NULL,
--     condition_emphysema BOOLEAN NOT NULL,
--     condition_bleedingProblems BOOLEAN NOT NULL,
--     condition_bloodDisease BOOLEAN NOT NULL,
--     condition_headInjury BOOLEAN NOT NULL,
--     condition_arthritis BOOLEAN NOT NULL,
--     condition_others TEXT,
--     FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );
