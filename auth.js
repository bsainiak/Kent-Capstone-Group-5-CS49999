let auth0Client = null;

// Initialize the Auth0 Client when the page loads
window.onload = async () => {
    try {
        auth0Client = await auth0.createAuth0Client({
            // 🛑 STOP: Replace these two lines with your real keys from the Auth0 Dashboard!
            domain: "YOUR_REAL_AUTH0_DOMAIN", 
            clientId: "YOUR_REAL_CLIENT_ID",
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
        window.history.replaceState({}, document.title, "/"); // Cleans up the URL
    }

    // Check if the user is currently logged in
    const isAuthenticated = await auth0Client.isAuthenticated();

    if (isAuthenticated) {
        console.log("User is successfully authenticated!");
        const user = await auth0Client.getUser();
        
        // 1. Update Navigation Buttons
        const loginBtn = document.getElementById("btn-login");
        const logoutBtn = document.getElementById("btn-logout");
        
        if (loginBtn) loginBtn.style.display = "none"; // Hide Log In
        if (logoutBtn) logoutBtn.style.display = "inline-block"; // Show Log Out

        // 2. Populate Account Page (if they are on account.html)
        if (window.location.pathname.includes("account.html")) {
            const emailDisplay = document.getElementById("user-email");
            const profilePic = document.getElementById("profile-pic");
            
            if (emailDisplay) emailDisplay.innerText = user.email;
            if (profilePic) profilePic.src = user.picture;
        }

    } else {
        console.log("User is not logged in.");
        
        // Ensure Log In is visible and Log Out is hidden for guests
        const loginBtn = document.getElementById("btn-login");
        const logoutBtn = document.getElementById("btn-logout");
        
        if (loginBtn) loginBtn.style.display = "inline-block";
        if (logoutBtn) logoutBtn.style.display = "none";
    }

    // Attach Event Listener to ALL Login Buttons (Nav bar & Login Page)
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
