//sqlite3 code variation
const express = require('express');
const sqlite3 = require('sqlite3').verbose(); // Change from mysql to sqlite3
const fs = require('fs'); // reads seed.sql file
const path = require('path');
const app = express();

// Sets up SQL lite database
const db = new sqlite3.Database('./portfolio.db');

// builds a temporary database
const seedQuery = fs.readFileSync(path.join(__dirname, 'seed.sql'), 'utf8');

db.serialize(() => {
    // This executes seed.sql script
    db.exec(seedQuery, (err) => {
        if (err) {
            // Note: If tables already exist, it might show an error here
            console.log("Database initialized (or already exists).");
        } else {
            console.log("Successfully ran seed.sql");
        }
    });
});

// Checks that CSS and image files are loaded into the browser
// This tells Express to serve static files (like index.html and styles.css) 
app.use(express.static(__dirname));

app.use("/images", express.static(path.join(__dirname, 'images')));
//app.use("/images", express.static('images')); // Fixed: 'images' needs quotes


app.get('/api/photos', (req, res) => {
    const searchTerm = req.query.search; //searches from the details placed in the search bar
    
    let sql = 'SELECT DISTINCT Images.ImageID, Images.FilePath, Images.Cost FROM Images'; //displays all of the photos in the event of no search
    let params = [];

    if (searchTerm) {
    //Prevents the duplicate entries of photos being displayed (I later found that the error was from the database add extra photos on initialization)
    //It works currently but if needed remove the distinct portion of the query
    sql = `SELECT DISTINCT Images.ImageID, Images.FilePath, Images.Cost 
           FROM Images 
           INNER JOIN Event ON Images.EventID = Event.EventID 
           WHERE Event.Series LIKE ? OR Event.Location LIKE ? OR Event.Date LIKE ?`;
        
        //Searchs and returns the photos if the search contains any of the associated terms (race, date, location)
        params = [`%${searchTerm}%`, `%${searchTerm}%`, `%${searchTerm}%`];
    }

    //error catch if the database connection does not work.
    db.all(sql, params, (err, rows) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: "Database query failed" });
        }
        res.json(rows); 
    });
});


/*
// Fetch photos from the SQLite database
app.get('/api/photos', (req, res) => {
    // Select ImageID for keys and FilePath for the source
    const sql = 'SELECT ImageID, FilePath, Cost FROM Images';
    
    // gets all of the rows for sql lite
    db.all(sql, [], (err, rows) => {
        if (err) {
            console.error(err.message);
            return res.status(500).json({ error: "Database query failed" });
        }
        res.json(rows); 
    });
});
*/
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});

/*
const express = require('express') //requires installation of express
const {createPool} = require('mysql') //requires installation of mysql
const app = express();


//creates a pool to connect and log into the database
const pool = createPool({
    host: "localhost",
    user: "root",
    password: "rootuser",
    database: "photography_portfolio",
    connectionLimit: 10
})

//example query into the database
pool.query('select * from dbName.table', (err, res)=>{
    return console.log(res)
})

//Checks that CSS and image files are loaded into the browser
app.use(express.static('public'));
app.use("/images", express.static(images))

//Test photo and app.get code to see if downloads work
const mockPhotos = [
    { filePath: "images/_DSC5696.jpg", fileName: "photo1.jpg" },
    { filePath: "images/_DSC5700.jpg", fileName: "photo2.jpg" },
    { filePath: "images/_DSC5701.jpg", fileName: "photo3.jpg" }
];

// Fetch photos from the actual database
app.get('/api/photos', (req, res) => {
    //select ImageID for keys and FilePath for the source
    const sql = 'SELECT ImageID, FilePath, Cost FROM Images';
    pool.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Database query failed" });
        }
        res.json(results); 
    });
});

//app.use('/images', express.static('images'));
*/
//OLD
//Grabs the raw data (file names) from the database to build the website gallery
/*
app.get('/api/photos', (req, res) => {
    pool.query('SELECT filePath, fileName FROM table', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results); // Send the data as JSON to the frontend
    });
});
*/
