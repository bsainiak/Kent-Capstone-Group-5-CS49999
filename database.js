const express = require('express') //requires installation of express
const {createPool} = require('mysql') //requires installation of mysql
const app = express();


//creates a pool to connect and log into the database
const pool = createPool({
    host: "localhost",
    user: "root",
    password: "rootuser",
    database: "dbName",
    connectionLimit: 10
})

//example query into the database
pool.query('select * from dbName.table', (err, res)=>{
    return console.log(res)
})

//Checks that CSS and image files are loaded into the browser
app.use(express.static('public'));

//Test photo and app.get code to see if downloads work
const mockPhotos = [
    { filePath: "images/_DSC5696.jpg", fileName: "photo1.jpg" },
    { filePath: "images/_DSC5700.jpg", fileName: "photo2.jpg" },
    { filePath: "images/_DSC5701.jpg", fileName: "photo3.jpg" }
];

app.get('/api/photos', (req, res) => {
    res.json(mockPhotos);
});

app.use('/images', express.static('images'));

//Grabs the raw data (file names) from the database to build the website gallery
/*
app.get('/api/photos', (req, res) => {
    pool.query('SELECT filePath, fileName FROM table', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results); // Send the data as JSON to the frontend
    });
});
*/