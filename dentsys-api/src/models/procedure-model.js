import pool from '../../config/db.js';

export default class Procedure {
    constructor(prcd_id, prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP){
        this.prcd_id = prcd_id;
        this.prcd_name = prcd_name;
        this.prcd_priceType = prcd_priceType;
        this.prcd_category = prcd_category;
        this.prcd_basePrice = prcd_basePrice;
        this.prcd_minDP = prcd_minDP;
    }

    // POST
    static async createProcedure(data){
        const {prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP} = data;
        const queryStr = 'INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP) VALUES (?, ?, ?, ?, ?)';
        const values = [prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP];
        
        try{
            const [result] = await pool.query(queryStr, values);
            const newProcedure = result.insertId;
            if(!newProcedure){
                throw new Error('Error creating procedure');
            } else {
                console.log('Procedure created successfully:', newProcedure);
                return newProcedure;
            }
        } catch (error) {
            console.log('Error creating procedure:', error);
            throw error;
        }

    }

    static async getProcedureById(prcd_id){
        const queryStr = 'SELECT * FROM procedures WHERE prcd_id = ?';
        const values = [prcd_id];
        try {
            const [procedure] = await pool.query(queryStr, values);
            return procedure;
        } catch (error) {
            console.error('Error getting procedure by ID:', error);
            throw error;
        }
    }

    static async getAllProcedures(){
        const queryStr = 'SELECT * FROM procedures';
        try {
            const [procedures] = await pool.query(queryStr);
            return procedures;
        } catch (error) {
            console.error('Error getting all procedures:', error);
            throw error;
        }
    }

    static async getProceduresByCategory(prcd_category){
        const queryStr = 'SELECT * FROM procedures WHERE prcd_category = ?';
        const values = [prcd_category];
        const [procedures] = await pool.query(queryStr, values);
        return procedures;
    }

    static async updProcedure(data){
        const {prcd_id, prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP} = data;
        console.log('Procedure data:', data);
        const queryStr = `
            UPDATE procedures
            SET
            prcd_name = ?,
            prcd_priceType = ?,
            prcd_category = ?,
            prcd_basePrice = ?,
            prcd_minDP = ?
            WHERE
            prcd_id = ?;
        `;
        const values = [prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP, prcd_id];
        try {
            const [result] = await pool.query(queryStr, values);
            if(result.affectedRows === 0){
                console.log('Error updating procedure');
                throw new Error('Error updating procedure');
            } else {
                console.log('Procedure updated successfully:', result);
                return {
                    affectedRows: result.affectedRows,
                    message: 'Procedure updated successfully',
                    patient_id: prcd_id
                }
            }
        } catch (error) {
            console.error('Error updating procedure:', error);
            throw error;
        }
    }

    static async delProcedure(prcd_id){
        const queryStr = 'DELETE FROM procedures WHERE prcd_id = ?';
        const values = [prcd_id];
        await pool.query(queryStr, values);
    }
}