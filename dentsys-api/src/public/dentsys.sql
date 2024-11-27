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
    patient_nickname VARCHAR(50),
    patient_birthdate DATE,
    patient_age INT NOT NULL,
    patient_sex VARCHAR(50) NOT NULL,
    patient_nationality VARCHAR(50) NOT NULL,
    patient_religion VARCHAR(50) NOT NULL,
    patient_occupation VARCHAR(50) NOT NULL,
    patient_referrer VARCHAR(50),
    patient_reason VARCHAR(100) NOT NULL, -- Increased size from 50 to 100
    patient_totalBal FLOAT, -- Changed to FLOAT for balance
    patient_parentName VARCHAR(50),
    patient_parentOccupation VARCHAR(50)
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
    medical_bloodType VARCHAR(50) NOT NULL,
    medical_bloodPressure VARCHAR(50) NOT NULL,
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
    allergies_sulfaDrugs BOOLEAN NOT NULL,
    allergies_aspirin BOOLEAN NOT NULL,
    allergies_latex BOOLEAN NOT NULL,
    allergies_others TEXT,

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE -- Applied cascading actions
);

-- PROCEDURES TABLE
CREATE TABLE IF NOT EXISTS procedures (
    prcd_id INT AUTO_INCREMENT PRIMARY KEY,
    prcd_name VARCHAR(100) NOT NULL,
    prcd_priceType ENUM('Fixed', 'Variable', 'Downpayment', 'Unit') NOT NULL,
    prcd_category VARCHAR(50) NOT NULL,
    prcd_minDP DECIMAL(10, 2),
    prcd_basePrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS patient_treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    treatment_date DATE NOT NULL,
    treatment_prcdName TEXT NOT NULL,
    treatment_toothNo VARCHAR(50) NOT NULL,
    treatment_dentist VARCHAR(50) NOT NULL,
    treatment_charged DECIMAL NOT NULL,
    treatment_paid DECIMAL NOT NULL,
    treatment_balance FLOAT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE IF NOT EXISTS conditions (  
    condition_id INT AUTO_INCREMENT PRIMARY KEY,
    condition_name VARCHAR(50) NOT NULL UNIQUE,
    condition_description TEXT
);

CREATE TABLE IF NOT EXISTS patient_conditions (
    patientCondition_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    condition_id INT NOT NULL,
    patientCondition_status BOOLEAN,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (condition_id) REFERENCES conditions(condition_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- insert default conditions data 
INSERT INTO conditions (condition_name, condition_description) VALUES ('highBlood', 'High blood pressure');
INSERT INTO conditions (condition_name, condition_description) VALUES ('lowBlood', 'Low blood pressure');
INSERT INTO conditions (condition_name, condition_description) VALUES ('epilepsy', 'Seizure disorder');
INSERT INTO conditions (condition_name, condition_description) VALUES ('aids', 'Acquired Immunodeficiency Syndrome');
INSERT INTO conditions (condition_name, condition_description) VALUES ('std', 'Sexually Transmitted Disease');
INSERT INTO conditions (condition_name, condition_description) VALUES ('stomachUlcer', 'Peptic or stomach ulcer');
INSERT INTO conditions (condition_name, condition_description) VALUES ('faintingSeizures', 'History of fainting or seizures');
INSERT INTO conditions (condition_name, condition_description) VALUES ('rapidWeightLoss', 'Rapid weight loss');
INSERT INTO conditions (condition_name, condition_description) VALUES ('radTherapy', 'Radiation therapy');
INSERT INTO conditions (condition_name, condition_description) VALUES ('jointReplacement', 'Joint replacement surgery');
INSERT INTO conditions (condition_name, condition_description) VALUES ('heartSurgery', 'History of heart surgery');
INSERT INTO conditions (condition_name, condition_description) VALUES ('heartAttack', 'History of heart attack');
INSERT INTO conditions (condition_name, condition_description) VALUES ('heartDisease', 'Heart disease');
INSERT INTO conditions (condition_name, condition_description) VALUES ('heartMurmur', 'Heart murmur');
INSERT INTO conditions (condition_name, condition_description) VALUES ('thyroid', 'Thyroid issues');
INSERT INTO conditions (condition_name, condition_description) VALUES ('hepatitisLiver', 'Hepatitis / liver issues');
INSERT INTO conditions (condition_name, condition_description) VALUES ('jaundice', 'Hepatits / Jaundice');
INSERT INTO conditions (condition_name, condition_description) VALUES ('rheumaticFever', 'Rheumatic fever');
INSERT INTO conditions (condition_name, condition_description) VALUES ('hayFever', 'Hay fever');
INSERT INTO conditions (condition_name, condition_description) VALUES ('respiratoryProblems', 'Respiratory problems');
INSERT INTO conditions (condition_name, condition_description) VALUES ('tuberculosis', 'Tuberculosis');
INSERT INTO conditions (condition_name, condition_description) VALUES ('swollenAnkles', 'Swollen ankles');
INSERT INTO conditions (condition_name, condition_description) VALUES ('kidneyDisease', 'Kidney disease');
INSERT INTO conditions (condition_name, condition_description) VALUES ('diabetes', 'Diabetes');
INSERT INTO conditions (condition_name, condition_description) VALUES ('chestPain', 'Chest pain');
INSERT INTO conditions (condition_name, condition_description) VALUES ('stroke', 'History of stroke');
INSERT INTO conditions (condition_name, condition_description) VALUES ('tumors', 'History of tumors');
INSERT INTO conditions (condition_name, condition_description) VALUES ('anemia', 'Anemia');
INSERT INTO conditions (condition_name, condition_description) VALUES ('angina', 'Angina');
INSERT INTO conditions (condition_name, condition_description) VALUES ('asthma', 'Asthma');
INSERT INTO conditions (condition_name, condition_description) VALUES ('emphysema', 'Emphysema');
INSERT INTO conditions (condition_name, condition_description) VALUES ('bleedingProblems', 'Bleeding problems');
INSERT INTO conditions (condition_name, condition_description) VALUES ('bloodDisease', 'Blood disease');
INSERT INTO conditions (condition_name, condition_description) VALUES ('headInjury', 'History of head injury');
INSERT INTO conditions (condition_name, condition_description) VALUES ('arthritis', 'Arthritis');
INSERT INTO conditions (condition_name, condition_description) VALUES ('others', 'Other health conditions');

-- INSERT DEFAULT PROCEDURES
-- consultations
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Check up & Consultation', 'Fixed', 'Consultation', 0, 300);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Check up & Consultation w/ Cert', 'Fixed', 'Consultation', 0, 500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Check up & Consultation (TMJ)', 'Fixed', 'Consultation', 0, 100);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('TMD Screening/Evaluation w Machine', 'Fixed', 'Consultation', 0, 5000);
-- oral prophylaxis
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Mild', 'Fixed', 'Oral Prophylaxis', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Moderate', 'Fixed', 'Oral Prophylaxis', 0, 1500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Severe', 'Fixed', 'Oral Prophylaxis', 0, 2000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fluoride Treatment', 'Fixed', 'Oral Prophylaxis', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Mild (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 1500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Moderate (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 2000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Severe (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 2500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Bracket Removal w/ OP & Polishing', 'Fixed', 'Oral Prophylaxis', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Deep Scaling & Root Planning (Perio Case)', 'Unit', 'Oral Prophylaxis', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Deep Scaling & Root Planning w Flap', 'Unit', 'Oral Prophylaxis', 0, 5000);
-- oral surgery
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Simple Extraction', 'Fixed', 'Oral Surgery', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Minor Surgery (flap, bone reduction, root splitting)', 'Variable', 'Oral Surgery', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Odontectomy (wisdom tooth surgery)', 'Variable', 'Oral Surgery', 0, 8000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Gingivectomy', 'Unit', 'Oral Surgery', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Additional Anesthesia', 'Fixed', 'Oral Surgery', 0, 200);
-- tooth restoration
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Per Surface', 'Unit', 'Tooth Restoration', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Sealant', 'Fixed', 'Tooth Restoration', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fiber Reinforced Build-up', 'Fixed', 'Tooth Restoration', 0, 3000);
-- crowns & veneers