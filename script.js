const searchInput = document.getElementById('search-input');
const gallery = document.getElementById('photo-gallery');
const modal = document.getElementById('photoModal');
const modalImg = document.getElementById('modalImage');
const closeModal = document.querySelector('.close-modal');

var selectedImageData = {
    id: null,
    filePath: '',
    cost: 0
};

// Gallery Loading Logic
async function loadGallery(search = '')
{
    if (search.toLowerCase() === 'all') search = '';
    try
    {
        gallery.innerHTML = '<p>Searching...</p>';
        const url = search ? `/api/photos?search=${encodeURIComponent(search)}` : '/api/photos';
        const response = await fetch(url);
        const photos = await response.json();

        gallery.innerHTML = ''; 
        if (photos.length === 0)
        {
            gallery.innerHTML = `<p class="no-results">No photos found for "${search}".</p>`;
            return;
        }

        photos.forEach(photo =>
        {
            const card = document.createElement('div');
            card.className = 'card';
            //card.innerHTML = `<img src="${photo.FilePath}.jpg" alt="Gallery Image">`;
            card.innerHTML = `
                <img src="${photo.FilePath}.jpg" 
                    alt="Gallery Image" 
                    data-id="${photo.ImageID}" 
                    data-path="${photo.FilePath}.jpg" 
                    data-cost="${photo.Cost}">`;
            gallery.appendChild(card);
        });
    }
    catch (err)
    {
        gallery.innerHTML = "<p>Error loading gallery.</p>";
    }
}

gallery.addEventListener('click', (e) =>
{
    if (e.target.tagName === 'IMG')
    {

        selectedImageData.id = e.target.dataset.id;
        selectedImageData.filePath = e.target.dataset.path;
        selectedImageData.cost = e.target.dataset.cost;

        modal.style.display = "block";
        modalImg.src = e.target.src;

        // 1. Reset the modal UI so the new script has a fresh place to render
        const paymentOptions = document.getElementById('payment_options');
        paymentOptions.innerHTML = ''; 
        document.getElementById('alerts').innerHTML = '';
        document.getElementById('loading').classList.remove('hide');

        // 2. Remove any previous instances of script.js to prevent conflicts
        const oldScript = document.getElementById('paypal-execution-script');
        if (oldScript) oldScript.remove();

        // 3. Inject the script with a unique ID and timestamp
        const script = document.createElement('script');
        script.id = 'paypal-execution-script';
        script.src = "paypal.js?t=" + new Date().getTime(); 
        document.body.appendChild(script);
                
        console.log("Loading payment for: " + e.target.src);
    }
});

closeModal.onclick = () => modal.style.display = "none";
window.onclick = (event) => { if (event.target == modal) modal.style.display = "none"; };

   
searchInput.addEventListener('keypress', (e) =>
{
    if (e.key === 'Enter') loadGallery(searchInput.value.trim());
});

document.querySelectorAll('.sidebar-link').forEach(link =>
{
    link.addEventListener('click', (e) =>
    {
        e.preventDefault();
        const term = link.getAttribute('data-search');
        searchInput.value = term;
        loadGallery(term);
    });
});

// Initialize
window.onload = () => loadGallery();

// Featured Download Logic
const mockPhotoPath = "images/Featured-Photo.jpg"; 
const downloadBtn = document.getElementById('featured-download');
downloadBtn.href = mockPhotoPath;
downloadBtn.setAttribute('download', "featured_image.jpg");