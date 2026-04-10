let auth0Client = null;

window.onload = async () => {
    // 1. Initialize Auth0 with Local Storage Enabled
    auth0Client = await auth0.createAuth0Client({
        domain: "dev-mofp6o657an4qvyp.us.auth0.com", 
        clientId: "kZMspkx3muJ92A8p73N2RU1QO7wbWnh0",
        authorizationParams: {
            redirect_uri: window.location.origin
        },
        cacheLocation: 'localstorage' // This is the magic fix that keeps them logged in across pages!
    });

    // 2. Catch the user when they return from the Auth0 login screen
    if (window.location.search.includes("code=") && window.location.search.includes("state=")) {
        await auth0Client.handleRedirectCallback();
        window.history.replaceState({}, document.title, window.location.pathname); // Cleans up the URL bar
    }

    // 3. Check if they are logged in, and update the pages!
    const isAuthenticated = await auth0Client.isAuthenticated();
    
    if (isAuthenticated) {
        const user = await auth0Client.getUser();
        
        // If we are on the Account page, fill in their info
        if (document.getElementById('profile-name')) {
            document.getElementById('profile-name').innerText = user.name || "Client";
            document.getElementById('profile-email').innerText = user.email;
            document.getElementById('profile-pic').src = user.picture;
        }

        // Hide login buttons, show logout if you have them
        if (document.getElementById('btn-login')) document.getElementById('btn-login').style.display = 'none';
        if (document.getElementById('btn-logout')) document.getElementById('btn-logout').style.display = 'block';
    }
};

// 4. Button Click Logic
if (document.getElementById('btn-login')) {
    document.getElementById('btn-login').addEventListener('click', () => {
        auth0Client.loginWithRedirect();
    });
}

if (document.getElementById('btn-logout')) {
    document.getElementById('btn-logout').addEventListener('click', () => {
        auth0Client.logout({ logoutParams: { returnTo: window.location.origin } });
    });
}
