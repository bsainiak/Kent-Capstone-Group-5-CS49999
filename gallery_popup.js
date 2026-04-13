const modal = document.getElementById("photoModal");
const modalImage = document.getElementById("modalImage");
const closeBtn = document.querySelector(".close-modal");

// Open modal when clicking image
document.querySelectorAll(".card img").forEach(img =>
{
    img.addEventListener("click", function ()
    {
        modalImage.src = this.src;
        modal.style.display = "flex";

        document.getElementById("alerts").innerHTML = "";

        // Render PayPal button ONLY when modal opens
        renderPayPalButtons();
    });
});

// Close modal
closeBtn.addEventListener("click", () =>
{
    modal.style.display = "none";
    document.getElementById("paypal-button-container").innerHTML = "";
});

// Close when clicking outside modal
window.addEventListener("click", (e) =>
{
    if (e.target === modal)
    {
        modal.style.display = "none";
        document.getElementById("paypal-button-container").innerHTML = "";
    }
});
