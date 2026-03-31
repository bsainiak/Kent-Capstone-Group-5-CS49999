const express = require('express');
const axios = require('axios');
const app = express();

app.use(express.json());

// Function to get Auth0 Management API Token
async function getAuth0ManagementToken() {
    try {
        const response = await axios.post(`https://YOUR_AUTH0_DOMAIN/oauth/token`, {
            client_id: 'YOUR_BACKEND_MOCK_API_CLIENT_ID', 
            client_secret: 'YOUR_BACKEND_MOCK_API_CLIENT_SECRET',
            audience: 'https://YOUR_AUTH0_DOMAIN/api/v2/',
            grant_type: 'client_credentials'
        });
        return response.data.access_token;
    } catch (error) {
        console.error("Error getting Auth0 token:", error.message);
        return null;
    }
}

// PayPal Webhook Endpoint (Listens for successful payments)
app.post('/webhook/paypal', async (req, res) => {
    const { event_type, resource } = req.body;

    // Check if payment was completely captured by Jacob's PayPal setup
    if (event_type === 'PAYMENT.CAPTURE.COMPLETED') {
        const auth0UserId = resource.custom_id; // Retrieved from Paypal_Buttons.js

        if (auth0UserId && auth0UserId !== "guest") {
            console.log(`Processing Auth0 upgrade for user: ${auth0UserId}`);
            
            const token = await getAuth0ManagementToken();
            
            if (token) {
                try {
                    // Grant the user access to their purchased photos in Auth0 metadata
                    await axios.patch(`https://YOUR_AUTH0_DOMAIN/api/v2/users/${auth0UserId}`, 
                        { 
                            user_metadata: { photoAccess: true } 
                        }, 
                        { 
                            headers: { Authorization: `Bearer ${token}` } 
                        }
                    );
                    console.log(`Successfully updated Auth0 permissions for: ${auth0UserId}`);
                } catch (error) {
                    console.error('Failed to update Auth0 user metadata:', error.message);
                }
            }
        } else {
            console.log("Payment received for guest. No Auth0 account updated.");
        }
    }
    
    // Always return a 200 OK so PayPal knows we received the webhook
    res.status(200).send('Webhook received successfully');
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Backend Payment Server running on port ${PORT}`);
    console.log(`Listening for PayPal webhooks at http://localhost:${PORT}/webhook/paypal`);
});
