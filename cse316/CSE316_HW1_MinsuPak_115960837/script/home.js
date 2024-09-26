const smallMenu = document.querySelector('#small-menu');
const menuLinks = document.querySelector('.navbar_menu');
let mainContent = document.getElementById('main_content');
let smallMenuOpen = false;


smallMenu.addEventListener('click', function() {
    smallMenu.classList.toggle('is-active');
    menuLinks.classList.toggle('active');

    mainContent = document.getElementById('main_content');
    
    //pushes content below navbar down when open
    setTimeout(function() {if (smallMenuOpen) { 
        mainContent.style.marginTop = "0px"; //remove extra space
        smallMenuOpen = false;
    } else {
        mainContent.style.marginTop = "198px";
        smallMenuOpen = true;
    }}, 300);
});

// creates a single 'card' of facility information
// takes an array of necessary information - 'facility'
//          the container to put the card - 'mainContainer'
//          an array of 3 svg links - 'svgarr'
function createCard(facility, mainContainer, svgarr) {
    let cardContainer = document.createElement('div');
    cardContainer.classList.add('facil_container');
    mainContainer.appendChild(cardContainer);

    let img = document.createElement('img');
    img.setAttribute("src", facility[6]);
    img.classList.add('facil_list_img');
    cardContainer.appendChild(img);

    let detailContainer = document.createElement('div');
    detailContainer.classList.add('facil_list_details');
    cardContainer.appendChild(detailContainer);

    let title = document.createElement('p');
    title.textContent = facility[0];
    title.classList.add("facil_list_title");
    detailContainer.appendChild(title);

    cardContainer = document.createElement('div');
    cardContainer.classList.add('facil_desc_box');
    detailContainer.appendChild(cardContainer);

    let desc = document.createElement('p');
    desc.textContent = facility[1];
    cardContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", svgarr[0]);
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility[2];
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", svgarr[1]);
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility[3];
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", svgarr[2]);
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility[4];
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);
}
