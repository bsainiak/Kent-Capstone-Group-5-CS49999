let auth0Client = null;

window.onload = async () => {
  // Initialize Auth0
  auth0Client = await auth0.createAuth0Client({
    domain: "YOUR_AUTH0_DOMAIN",
    clientId: "YOUR_AUTH0_CLIENT_ID",
    authorizationParams: {
      redirect_uri: window.location.origin
    }
  });

  // Handle returning from the Auth0 login screen
  if (location.search.includes("state=") && location.search.includes("code=")) {
    await auth0Client.handleRedirectCallback();
    window.history.replaceState({}, document.title, "/");
  }

  // Check login status
  const isAuthenticated = await auth0Client.isAuthenticated();
  const loginBtn = document.getElementById("btn-login");
  const logoutBtn = document.getElementById("btn-logout");

  // Toggle buttons and store user data based on authentication
  if (isAuthenticated) {
    if (loginBtn) loginBtn.style.display = "none";
    if (logoutBtn) logoutBtn.style.display = "inline-block";
    window.authUser = await auth0Client.getUser(); 
  } else {
    if (loginBtn) loginBtn.style.display = "inline-block";
    if (logoutBtn) logoutBtn.style.display = "none";
  }

  // Attach click events
  if (loginBtn) {
    loginBtn.addEventListener("click", () => auth0Client.loginWithRedirect());
  }
  if (logoutBtn) {
    logoutBtn.addEventListener("click", () => auth0Client.logout({ 
      logoutParams: { returnTo: window.location.origin } 
    }));
  }
};
