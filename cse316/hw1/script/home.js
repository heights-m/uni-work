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
