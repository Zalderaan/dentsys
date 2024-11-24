import pool from '../../config/db.js';

export default class Procedure {
    constructor(prcd_id, prcd_name, prcd_priceType, prcd_category, prcd_basePrice){
        this.prcd_id = prcd_id;
        this.prcd_name = prcd_name;
        this.prcd_priceType = prcd_priceType;
        this.prcd_category = prcd_category;
        this.prcd_basePrice = prcd_basePrice;
    }

    // POST
    static async createProcedure(data){
        const {prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP} = data;
        const queryStr = 'INSERT INTO procedures (prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP) VALUES (?, ?, ?, ?, ?)';
        const values = [prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_minDP];
        const [result] = await pool.query(queryStr, values);
        return result.insertId;
    }

    static async getProcedureById(prcd_id){
        const queryStr = 'SELECT * FROM procedures WHERE prcd_id = ?';
        const values = [prcd_id];
        const [procedure] = await pool.query(queryStr, values);
        return procedure;
    }

    static async getAllProcedures(){
        const queryStr = 'SELECT * FROM procedures';
        const [procedures] = await pool.query(queryStr);
        return procedures;
    }

    static async getProceduresByCategory(prcd_category){
        const queryStr = 'SELECT * FROM procedures WHERE prcd_category = ?';
        const values = [prcd_category];
        const [procedures] = await pool.query(queryStr, values);
        return procedures;
    }

    static async updProcedure(data){
        const {prcd_id, prcd_name, prcd_priceType, prcd_category, prcd_basePrice} = data;
        const queryStr = `
            UPDATE procedures
            SET
            prcd_name = ?,
            prcd_priceType = ?,
            prcd_category = ?,
            prcd_basePrice = ?
            WHERE
            prcd_id = ?;
        `;
        const values = [prcd_name, prcd_priceType, prcd_category, prcd_basePrice, prcd_id];
        await pool.query(queryStr, values);
    }

    static async delProcedure(prcd_id){
        const queryStr = 'DELETE FROM procedures WHERE prcd_id = ?';
        const values = [prcd_id];
        await pool.query(queryStr, values);
    }
}