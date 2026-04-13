//sqlite3 code variation
const path = require('path');
//**************************************************
//  Initialize the running environment
//**************************************************
require('dotenv').config();
console.log("TESTING ENV:", process.env.CLIENT_ID ? "LOADED" : "NOT LOADED");

//**************************************************
//  Initialize the database
//**************************************************
const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('./database/portfolio.db');
const fs = require('fs');

const generatescript = fs.readFileSync('./database/sql/generate.sql', 'utf8');
const loadScript = fs.readFileSync('./database/sql/load.sql', 'utf8');


db.serialize(() => {
    // This executes generate.sql script
    db.exec(generatescript, (err) => {
        if (err) {
            console.log("Database Error!");
        } else {
            console.log("Executed 'generate.sql' Successfully.");
        }
    });
    // This executes load.sql script
    db.exec(loadScript, (err) => {
        if (err) {
            console.log("Load Error! Database may be alrady loaded.");
        } else {
            console.log("Executed 'load.sql' Successfully.");
        }
    });
});

//**************************************************
//  Set up search functionality
//**************************************************
const express = require('express');
const app = express();

app.use(express.static(__dirname));
app.use("/images", express.static(path.join(__dirname, 'images')));

app.get('/api/photos', (req, res) => {
    const searchTerm = req.query.search;
    
    let sql = 'SELECT DISTINCT Images.ImageID, Images.FilePath, Images.Cost FROM Images'; //displays all of the photos in the event of no search
    let params = [];

    if (searchTerm) {
    sql = `SELECT DISTINCT Images.ImageID, Images.FilePath, Images.Cost 
           FROM Images 
           INNER JOIN Events ON Images.EventID = Events.EventID 
           WHERE Events.EventName LIKE ? OR Events.Series LIKE ? OR Events.Location LIKE ? OR Events.EventDate LIKE ?`;
        
        params = [`%${searchTerm}%`, `%${searchTerm}%`, `%${searchTerm}%`, `%${searchTerm}%`];
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

//**************************************************
//  Set up PayPal functionality
//**************************************************
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use('/images', express.static('images'));

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
    const imageId = req.body.imageId;


    db.get('SELECT Cost FROM Images WHERE ImageID = ?', [imageId], (err, row) => {
        if (err) {
            console.error("Database Error:", err);
            return res.status(500).json({ error: "Internal Server Error" });
        }
        
        if (!row) {
            console.error("Image not found in DB for ID:", imageId);
            return res.status(404).json({ error: "Image not found" });
        }
    
        const price = row.Cost.toFixed(2);


    get_access_token()
        .then(access_token => {
            let order_data_json = {
                'intent': req.body.intent.toUpperCase(),
                'purchase_units': [{
                    'amount': {
                        'currency_code': 'USD',
                        'value': price
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

//**************************************************
//  Set up web page
//**************************************************

//Servers the index.html file
app.get('/', (req, res) => {
    res.sendFile(process.cwd() + '/index.html');
});
//Servers the style.css file
app.get('/style.css', (req, res) => {
    res.sendFile(process.cwd() + '/style.css');
});
//Servers the script.js file
app.get('/paypal.js', (req, res) => {
    res.sendFile(process.cwd() + '/paypal.js');
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});

//**************************************************
//  Clean up functions
//**************************************************

process.on('SIGINT', () => {
  console.log('\nClean up started.');

  db.close(() => {
    console.log('Database closed.');
    process.exit(0);
  });
});
