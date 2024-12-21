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
    patient_parentOccupation VARCHAR(50),
    patient_createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    patient_updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    prcd_priceType ENUM('Fixed', 'Variable', 'Down Payment', 'Unit', 'To Be Determined') NOT NULL,
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
    effective_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS dental_history (
    dental_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE,
    dental_previousDentist VARCHAR(50) NOT NULL,
    dental_lastVisit DATE,
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
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Check up & Consultation (TMJ)', 'Fixed', 'Consultation', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('TMD Screening/Evaluation w Machine', 'Fixed', 'Consultation', 0, 5000);
-- oral prophylaxis
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Mild OP', 'Fixed', 'Oral Prophylaxis', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Moderate OP', 'Fixed', 'Oral Prophylaxis', 0, 1500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Severe OP', 'Fixed', 'Oral Prophylaxis', 0, 2000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fluoride Treatment', 'Fixed', 'Oral Prophylaxis', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Mild OP (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 1500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Moderate OP (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 2000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Severe OP (w/ braces)', 'Fixed', 'Oral Prophylaxis', 0, 2500);
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
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('TR Per Surface', 'Unit', 'Tooth Restoration', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Sealant', 'Fixed', 'Tooth Restoration', 0, 1000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fiber Reinforced Build-up', 'Fixed', 'Tooth Restoration', 0, 3000);
-- crowns & veneers
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Direct Composite Veneer', 'Unit', 'Crowns & Veneers', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Zirconia Veneer/Crown', 'Unit', 'Crowns & Veneers', 0, 25000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Emax Veneer/Crown', 'Unit', 'Crowns & Veneers', 0, 20000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('PFM Crown', 'Unit', 'Crowns & Veneers', 0, 8000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Tilite Crown', 'Unit', 'Crowns & Veneers', 0, 10000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Plastic Crown', 'Unit', 'Crowns & Veneers', 0, 4000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Ceramage Crown', 'Unit', 'Crowns & Veneers', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('PMMA Crown', 'Unit', 'Crowns & Veneers', 0, 4000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('SSC', 'Unit', 'Crowns & Veneers', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fiber Reinforced Maryland', 'Unit', 'Crowns & Veneers', 0, 6000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Gold Crown (TBD)', 'To Be Determined', 'Crowns & Veneers', 0, 0);
-- dentures
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Standard - Complete Denture', 'Unit', 'Dentures', 0, 10000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Standard - Partial Denture (Anterior & Posterior)', 'Unit', 'Dentures', 0, 8000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Standard - Partial Denture (Anterior OR Posterior)', 'Unit', 'Dentures', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Thermosens/Flexible - Complete Denture', 'Unit', 'Dentures', 0, 20000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Thermosens/Flexible  - Partial Denture (Anterior & Posterior)', 'Unit', 'Dentures', 0, 18000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Thermosens/Flexible  - Partial Denture (Anterior OR Posterior)', 'Unit', 'Dentures', 0, 15000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('IVOCAP', 'Unit', 'Dentures', 0, 25000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Combination of Metal', 'Unit', 'Dentures', 0, 25000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Repair', 'Unit', 'Dentures', 0, 2000);
-- root canal treatment
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('RCT', 'Unit', 'Root Canal Treatment', 0, 8000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('RCT w/ Big Apical Lesion', 'Unit', 'Root Canal Treatment', 0, 10000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Retreatment', 'Unit', 'Root Canal Treatment', 0, 10000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Pulpectomy', 'Unit', 'Root Canal Treatment', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Pulpotomoy', 'Unit', 'Root Canal Treatment', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Fiber Post', 'Unit', 'Root Canal Treatment', 0, 3000);
-- orthodontics
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Metal', 'Down Payment', 'Orthodontics', 10000, 50000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Ceramic', 'Down Payment', 'Orthodontics', 20000, 80000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Sapphire', 'Down Payment', 'Orthodontics', 20000, 80000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('SWLF', 'Down Payment', 'Orthodontics', 20000, 80000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Self-Ligating', 'Down Payment', 'Orthodontics', 30000, 100000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Clear Aligners', 'Fixed', 'Orthodontics', 30000, 100000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Recement of Bracket', 'Fixed', 'Orthodontics', 0, 500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Replacement (Lost Bracket, Buccal Tube)', 'Fixed', 'Orthodontics', 0, 800);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Elastics', 'Fixed', 'Orthodontics', 0, 100);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Ortho Wax', 'Fixed', 'Orthodontics', 0, 50);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Ortho Kit', 'Fixed', 'Orthodontics', 0, 500);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Expander (Fixed)', 'Fixed', 'Orthodontics', 0, 10000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Expander (Removable)', 'Fixed', 'Orthodontics', 0, 8000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ("Hawley's Retainer", 'Unit', 'Orthodontics', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Clear Plastic Retainer', 'Unit', 'Orthodontics', 0, 4000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Lingual Retainer', 'Unit', 'Orthodontics', 0, 3000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Mought/Night Guard', 'Unit', 'Orthodontics', 0, 5000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Splint/Bite Plane', 'Unit', 'Orthodontics', 0, 5000);
-- TMJ therapy
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('TMJ Therapy', 'Down Payment', 'TMJ Therapy', 25000, 50000);
-- whitening
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('Whitening - 3 Cycle/Session', 'Fixed', 'Whitening', 0, 15000);
-- implant
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('w/ PFM Crown', 'Fixed', 'Implant', 0, 100000);
INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_minDP, prcd_basePrice) VALUES ('w/ Zirconia', 'Fixed', 'Implant', 0, 120000);