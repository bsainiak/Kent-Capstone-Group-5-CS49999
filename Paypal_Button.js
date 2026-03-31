paypal.Buttons({
  createOrder: function(data, actions) {
    // Get the Auth0 user ID if they are logged in, otherwise tag as guest
    const userId = window.authUser ? window.authUser.sub : "guest";
    
    return actions.order.create({
      purchase_units: [{
        amount: {
          value: '15.00' // Make sure this matches Jacob's pricing
        },
        custom_id: userId // This sends the exact Auth0 ID to the backend webhook
      }]
    });
  },
  onApprove: function(data, actions) {
    return actions.order.capture().then(function(details) {
      alert('Transaction completed by ' + details.payer.name.given_name + '. You now have access to download this photo.');
      
      // Send them straight to the new downloads page you just made
      window.location.href = "downloads.html";
    });
  }
}).render('#paypal-button-container');
