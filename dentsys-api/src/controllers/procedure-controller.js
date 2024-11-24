import Procedure from '../models/procedure-model.js';

export default class ProcedureController {
    // POST
    static async addProcedure(req, res) {
        const data = req.body;
        try {
            const newProcedureId = await Procedure.createProcedure(data);
            const newProcedure = await Procedure.getProcedureById(newProcedureId);
            if(!newProcedure) {
                throw new Error('Error creating procedure');
            } else if (newProcedureId) {
                console.log('Procedure created successfully from controller:', newProcedure);
                return res.status(201).json({ message: 'Procedure created successfully from controller', newProcedure});
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getOneProcedure(req, res) {
        try {
            const prcd_id = req.params.id;
            const procedure = await Procedure.getProcedureById(prcd_id);
            if(!procedure) {
                throw new Error('Error fetching procedure');
            } else if (procedure) {
                console.log('Procedure fetched successfully from controller:', procedure);
                return res.status(200).json({ message: 'Procedure fetched successfully from controller', procedure});
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getAllProcedures(req, res) {
        try {
            const allProcedures = await Procedure.getAllProcedures();
            if(!allProcedures) {
                throw new Error('Error fetching all procedures');
            } else if (allProcedures) {
                console.log('All procedures fetched successfully from controller:', allProcedures);
                return res.status(200).json({ message: 'All procedures fetched successfully from controller', allProcedures});
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async updateProcedure(req, res) {
        console.log('updateProcedure controller accessed:', req.body);
        const data = req.body;
        try {
            const updatedProcedure = await Procedure.updProcedure(data);
            if(!updatedProcedure) {
                throw new Error('Error updating procedure');
            } else {
                console.log('Procedure updated successfully from controller:', updatedProcedure);
                return res.status(200).json({ message: 'Procedure updated successfully from controller', updatedProcedure});
            }
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async deleteProcedure(req, res) {
        const prcd_id = req.params.id;
        try {
            await Procedure.delProcedure(prcd_id);
            console.log('Procedure deleted successfully from controller:', prcd_id);
            return res.status(200).json({ message: 'Procedure deleted successfully from controller', prcd_id});
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}