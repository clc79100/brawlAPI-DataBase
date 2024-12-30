const express = require('express');
const mysql = require('mysql2');

// Configuración de la aplicación
const app = express();
app.use(express.json());

// Configuración de la conexión a la base de datos
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', // Cambiar por tu usuario
    password: 'Reykarl08*', // Cambiar por tu contraseña
    database: 'brawlapi',
});

// Conexión a la base de datos
db.connect((err) => {
    if (err) {
        console.error('Error conectando a la base de datos:', err);
        process.exit(1);
    }
    console.log('Conectado a la base de datos MySQL');
});

// Leer todos los usuarios
app.get('/get/:id', (req, res) => {
    const {id} = req.params
    const query = `CALL GetBrawler(${id});`;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(200).json(results);
    });
});

// Inicializar el servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});
