let auth0Client = null;

// Initialize the Auth0 Client when the page loads
window.onload = async () => {
    try {
        auth0Client = await auth0.createAuth0Client({
            domain: "dev-mofp6o657an4qvyp.us.auth0.com", 
            clientId: "kZMspkx3muJ92A8p73N2RU1QO7wbWnh0",
            authorizationParams: {
                redirect_uri: window.location.origin
            }
        });
    } catch (error) {
        console.error("Auth0 Initialization Error:", error);
        return;
    }

    // Check if the user is returning from the Auth0 login page
    if (location.search.includes("state=") && location.search.includes("code=")) {
        await auth0Client.handleRedirectCallback();
        window.history.replaceState({}, document.title, "/"); 
    }

    // Check if the user is currently logged in
    const isAuthenticated = await auth0Client.isAuthenticated();

    if (isAuthenticated) {
        console.log("User is successfully authenticated!");
        const user = await auth0Client.getUser();
        
        // 1. Update Navigation Buttons
        const loginBtn = document.getElementById("btn-login");
        const logoutBtn = document.getElementById("btn-logout");
        
        if (loginBtn) loginBtn.style.display = "none"; 
        if (logoutBtn) logoutBtn.style.display = "inline-block"; 

        // 2. Populate Account Page 
        if (window.location.pathname.includes("account.html")) {
            const emailDisplay = document.getElementById("user-email");
            const profilePic = document.getElementById("profile-pic");
            
            if (emailDisplay) emailDisplay.innerText = user.email;
            if (profilePic) profilePic.src = user.picture;
        }

    } else {
        console.log("User is not logged in.");
        
        const loginBtn = document.getElementById("btn-login");
        const logoutBtn = document.getElementById("btn-logout");
        
        if (loginBtn) loginBtn.style.display = "inline-block";
        if (logoutBtn) logoutBtn.style.display = "none";
    }

    // Attach Event Listener to ALL Login Buttons
    const loginButtons = document.querySelectorAll("#btn-login");
    loginButtons.forEach(btn => {
        btn.addEventListener("click", async () => {
            await auth0Client.loginWithRedirect();
        });
    });

    // Attach Event Listener to the Logout Button
    const logoutBtn = document.getElementById("btn-logout");
    if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
            auth0Client.logout({
                logoutParams: {
                    returnTo: window.location.origin
                }
            });
        });
    }
};
