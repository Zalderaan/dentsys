const Contact = require('../models/contact-model.js');

class ContactController {
    // POST 
    static async addContact(req, res) {
        const data = req.body;
        console.log('received contact data: ', data);
        try {
            const newContactId = await Contact.createContact(data);
            console.log('new contact id: ', newContactId);
            const newContact = await Contact.getContactByContactId(newContactId);
            return res.status(201).json({ message: 'Contact created successfully from controller', newContact});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getContact(req, res) {
        const data = req.params.id;
        try {
            const contact = await Contact.getContact(data);
            return res.status(200).json({ message: 'Contact retrieved successfully from controller', contact});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async updateContact(req, res) {
        const data = req.body;
        const patient_id = req.params.id;
        data.patient_id = patient_id;
        try {
            const updatedContact = await Contact.updateContact(data);
            return res.status(200).json({ message: 'Contact updated successfully from controller', updatedContact});
        } 
        catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async removeContact(req, res) {
        const data = req.params.id;
        try {
            const delContact = await Contact.deleteContact(data);
            return res.status(200).json({ message: 'Contact deleted successfully from controller', delContact});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = ContactController;