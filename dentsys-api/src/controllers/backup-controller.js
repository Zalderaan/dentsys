const Backup = require('../models/backup-model');

class BackupController {
    static async backup(req, res) {
        try {
            const customPath = req.body.path;
            console.log('customPath in controller: ', customPath);
            await Backup.performBackup(customPath);
            return res.status(200).json({ message: 'Backup successful!' });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    static async restore(req, res) {
        try{
            const backupName = req.body.path;
            console.log('backupName in controller: ', backupName);
            await Backup.restoreBackup(backupName);
            return res.status(200).json({ message: 'Restore successful!' });
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}

module.exports = BackupController;