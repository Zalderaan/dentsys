import pool from '../../config/db.js';

export default class Contact {
    constructor(email, home_address, home_number, office_number, fax_number, mobile_number, patient_id){
        this.email = email;
        this.home_address = home_address;
        this.home_number = home_number;
        this.office_number = office_number;
        this.fax_number = fax_number;
        this.mobile_number = mobile_number;
        this.patient_id = patient_id;
    }

    static async createContact(data) {
        const { email, home_address, home_number, office_number, fax_number, mobile_number, patient_id } = data;

        const queryStr = 'INSERT INTO contact (contact_email, contact_homeAddress, contact_homeNo, contact_workNo, contact_faxNo, contact_mobileNo, patient_id) VALUES (?, ?, ?, ?, ?, ?, ?)';
        const values = [email, home_address, home_number, office_number, fax_number, mobile_number, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            const newContact = result.insertId;
            if (newContact) {
                console.log('Contact created successfully from model', newContact);
                return newContact;
            } else {
                throw new Error('Error creating contact');
            }
        } catch (error) {
            console.log('Error creating contact from model', error);
            if (error.code === 'ER_DUP_ENTRY') {
                throw new Error('Contact already exists');
            }
            throw error;
        }
    }

    static async getContact(id) {
        const queryStr = 'SELECT * FROM contact WHERE patient_id = ?';

        try {
            const [contact_result] = await pool.query(queryStr, [id]);

            if(contact_result.length === 0) {
                throw new Error('No contact found');
            } else if (contact_result.length > 1) {
                throw new Error('Multiple contacts found');
            }
            return contact_result;
        } catch (error) {
            console.log('Error getting contact from model', error);
            throw error;
        }
    }

    static async updateContact(data) {
        const { email, home_address, home_number, office_number, fax_number, mobile_number, patient_id} = data;
        
        const queryStr = 'UPDATE contact SET contact_email = ?, contact_homeAddress = ?, contact_homeNo = ?, contact_workNo = ?, contact_faxNo = ?, contact_mobileNo = ? WHERE patient_id = ?';
        const values = [email, home_address, home_number, office_number, fax_number, mobile_number, patient_id];

        try {
            const [result] = await pool.query(queryStr, values);
            if (result.affectedRows === 0) {
                console.log('patient contacts does not exist, not updated');
                throw new Error('patient contacts does not exist, not updated');
            }

            console.log('Contact updated successfully from model');
            return {
                affectedRows: result.affectedRows,
                message: 'Contact updated successfully',
                patient_id: patient_id
            }
        
        } catch (error) {
            console.log('Error updating contact from model', error);
            throw error;
        }
    }

    static async deleteContact(id) {
        const queryStr = 'DELETE FROM contact WHERE patient_id = ?';
        try {
            const [result] = await pool.query(queryStr, [id]);
            if (result.affectedRows === 0) {
                console.log('Contact does not exist, not deleted');
                throw new Error('Contact does not exist, not deleted');
            }

            console.log('Contact deleted successfully from model');
            return {
                affectedRows: result.affectedRows,
                message: 'Contact deleted successfully',
                patient_id: id
            }
        } catch (error) {
            console.log('Error deleting contact from model', error);
            throw error;
        }
    }
}