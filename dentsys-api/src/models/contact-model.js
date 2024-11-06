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

    static async createContact(data){
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
            throw new Error ('Error creating contact', error);
        }
    }

    static async getContact(id) {
        const queryStr = 'SELECT * FROM contact WHERE patient_id = ?';

        try {
            const [contact_result] = await pool.query(queryStr, [id]);

            if(!contact_result) {
                throw new Error('No contact found');
            } else if (contact_result.length > 1) {
                throw new Error('Multiple contacts found');
            } else if (contact_result.length === 0) {
                return { message: 'No contact found' };
            }
            return contact_result;
        } catch (error) {
            console.log('Error getting contact from model', error);
            throw new Error ('Error getting contact', error);
        }
    }

    static async updateContact(data) {

    }

    static async deleteContact(id) {

    }
}