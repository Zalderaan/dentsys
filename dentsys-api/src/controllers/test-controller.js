import Contact from '../models/contact-model.js';

export default class TestController {
    // POST
    static async addPatient(req, res) {
        const data = req.body;
        console.log('data received:', data);
        const connection = await pool.getConnection();

        try {

            await connection.beginTransaction(); // start transaction

            const newPatient = await Patient.createPatient(data); // insert new patient data
            console.log('newPatient:', newPatient);
            
            const newPatientId = newPatient.patient_id;
            console.log('newPatientId:', newPatientId);

            data.patient_id = newPatientId; // add patient id to contact data
            console.log('data + patient id:', data);
            const newContact = await Contact.createContact(data); // insert new contact data

            await connection.commit(); // commit transaction

            return res.status(201).json({ 
                message: 'Patient created successfully from controller', 
                patient: newPatient, 
                contact: newContact
            });
        } 
        catch (error) {
            await connection.rollback(); // rollback transaction
            res.status(500).json({ error: error.message });
        } finally {
            connection.release(); // release connection
        }
    }

    static async createContact(req, res) {
        const data = req.body;
        try {
            const newContact = await Contact.createContact(data);
            return res.status(201).json({ message: 'Contact created successfully from controller', newContact});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }  
    }

    // GET
    static async getContact(req, res) {
        const data = req.params.id;
        try {
            const contact = await Contact.getContact(data);
            if (contact.message === 'No contact found') {
                return res.status(404).json({ message: 'No contact found' });
            }
            return res.status(200).json({ message: 'Contact retrieved successfully from controller', contact});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
    
    // PUT
    static async updateContact(req, res) {
        const data = req.body;
        try {
            const updatedContact = await Contact.updateContact(data);
            return res.status(200).json({ message: 'Contact updated successfully from controller', updatedContact});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // DELETE
    static async deleteContact(req, res) {
        const data = req.params.id;
        try {
            const deletedContact = await Contact.deleteContact(data);
            return res.status(200).json({ message: 'Contact deleted successfully from controller', deletedContact});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}