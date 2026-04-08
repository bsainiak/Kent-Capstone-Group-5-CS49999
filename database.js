//sqlite3 code variation
const express = require('express');
const sqlite3 = require('sqlite3').verbose(); // Change from mysql to sqlite3
const fs = require('fs'); // reads seed.sql file
const path = require('path');
const app = express();
require('dotenv').config();
console.log("TESTING ENV:", process.env.CLIENT_ID ? "LOADED" : "NOT LOADED");

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


app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use('/images', express.static('images'));
const port = process.env.PORT || 3000;
const environment = process.env.ENVIRONMENT || 'sandbox';
const client_id = process.env.CLIENT_ID;
const client_secret = process.env.CLIENT_SECRET;
const endpoint_url = environment === 'sandbox' ? 'https://api-m.sandbox.paypal.com' : 'https://api-m.paypal.com';
/**
 * Creates an order and returns it as a JSON response.
 * @function
 * @name createOrder
 * @memberof module:routes
 * @param {object} req - The HTTP request object.
 * @param {object} req.body - The request body containing the order information.
 * @param {string} req.body.intent - The intent of the order.
 * @param {object} res - The HTTP response object.
 * @returns {object} The created order as a JSON response.
 * @throws {Error} If there is an error creating the order.
 */
app.post('/create_order', (req, res) => {
    get_access_token()
        .then(access_token => {
            let order_data_json = {
                'intent': req.body.intent.toUpperCase(),
                'purchase_units': [{
                    'amount': {
                        'currency_code': 'USD',
                        'value': '10.00'
                    }
                }]
            };
            const data = JSON.stringify(order_data_json)

            fetch(endpoint_url + '/v2/checkout/orders', { //https://developer.paypal.com/docs/api/orders/v2/#orders_create
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${access_token}`
                    },
                    body: data
                })
                .then(res => res.json())
                .then(json => {
                    res.send(json);
                }) //Send minimal data to client
        })
        .catch(err => {
            console.log(err);
            res.status(500).send(err)
        })
});

/**
 * Completes an order and returns it as a JSON response.
 * @function
 * @name completeOrder
 * @memberof module:routes
 * @param {object} req - The HTTP request object.
 * @param {object} req.body - The request body containing the order ID and intent.
 * @param {string} req.body.order_id - The ID of the order to complete.
 * @param {string} req.body.intent - The intent of the order.
 * @param {object} res - The HTTP response object.
 * @returns {object} The completed order as a JSON response.
 * @throws {Error} If there is an error completing the order.
 */
app.post('/complete_order', (req, res) => {
    get_access_token()
        .then(access_token => {
            fetch(endpoint_url + '/v2/checkout/orders/' + req.body.order_id + '/' + req.body.intent, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${access_token}`
                    }
                })
                .then(res => res.json())
                .then(json => {
                    console.log(json);
                    res.send(json);
                }) //Send minimal data to client
        })
        .catch(err => {
            console.log(err);
            res.status(500).send(err)
        })
});

// Helper / Utility functions

//Servers the index.html file
app.get('/', (req, res) => {
    res.sendFile(process.cwd() + '/index.html');
});
//Servers the style.css file
app.get('/style.css', (req, res) => {
    res.sendFile(process.cwd() + '/style.css');
});
//Servers the script.js file
app.get('/script.js', (req, res) => {
    res.sendFile(process.cwd() + '/script.js');
});

//PayPal Developer YouTube Video:
//How to Retrieve an API Access Token (Node.js)
//https://www.youtube.com/watch?v=HOkkbGSxmp4
function get_access_token() {
    const auth = `${client_id}:${client_secret}`;
    const data = 'grant_type=client_credentials';
    
    return fetch(endpoint_url + '/v1/oauth2/token', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                // Ensure no hidden characters are in the auth string
                'Authorization': `Basic ${Buffer.from(auth.trim()).toString('base64')}`
            },
            body: data
        })
        .then(res => res.json())
        .then(json => {
            if (!json.access_token) {
                console.error("FAILED TO GET TOKEN:", json); // This will tell us if the creds are wrong
            }
            return json.access_token;
        })
        .catch(err => console.error("TOKEN FETCH ERROR:", err));
}




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
