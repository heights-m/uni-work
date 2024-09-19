const smallMenu = document.querySelector('#small-menu');
const menuLinks = document.querySelector('.navbar_menu');
const mainContent = document.querySelector('.main_content');
let smallMenuOpen = false;


smallMenu.addEventListener('click', function() {
    smallMenu.classList.toggle('is-active');
    menuLinks.classList.toggle('active');

    setTimeout(function() {if (smallMenuOpen) { //pushes content below navbar down when open
        mainContent.style.marginTop = "0px";
        smallMenuOpen = false;
    } else {
        mainContent.style.marginTop = "175px";
        smallMenuOpen = true;
    }}, 300);
});

function makeFacility(data) {
    for (facility of data) {
        console.log(facility);
    }
}

function getFacility() {
    fetch('../data/facility-info.json')
    .then(function(responce) {
        return responce.json();
    })
    .then(function(data) {
        makeFacility(JSON.parse(data));
    }) 
    .catch(function(error) {
        console.log('error: ', error);
    });
}

window.onload(getFacility());