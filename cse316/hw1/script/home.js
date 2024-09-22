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
    // let currentMargin = Number(mainContent.style.marginTop);
    // console.log(smallMenuOpen + ' ' + pushedMargin);
    // if (smallMenuOpen == true) {
    //     pushedMargin = currentMargin - 175;
    //     smallMenuOpen = false;
    // } else {
    //     pushedMargin = currentMargin + 175;
    //     smallMenuOpen = true;
    // }
    // console.log(smallMenuOpen + ' ' + pushedMargin)
    // console.log(175 -175)
    // mainContent.style.marginTop = "" + pushedMargin + "px";
    
});


function createCard(facility, mainContainer) {
    let cardContainer = document.createElement('div');
    cardContainer.classList.add('facil_container');
    mainContainer.appendChild(cardContainer);

    let img = document.createElement('img');
    img.setAttribute("src", facility.img);
    img.classList.add('facil_list_img');
    cardContainer.appendChild(img);

    let detailContainer = document.createElement('div');
    detailContainer.classList.add('facil_list_details');
    cardContainer.appendChild(detailContainer);

    let title = document.createElement('p');
    title.textContent = facility.name;
    title.classList.add("facil_list_title");
    detailContainer.appendChild(title);

    let desc = document.createElement('p');
    desc.textContent = facility.desc;
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/group_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.capacity;
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/location_on_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.location;
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/error_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    detailContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.avail;
    desc.classList.add('facil_list_txt');
    detailContainer.appendChild(desc);
}
