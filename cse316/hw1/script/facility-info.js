const CARDS_CONTAINER = document.getElementById('flex_container');

function createCard(facility) {
    let cardContainer = document.createElement('div');
    cardContainer.classList.add('facil_container');
    CARDS_CONTAINER.appendChild(cardContainer);

    let img = document.createElement('img');
    img.setAttribute("src", facility.img);
    img.classList.add('facil_list_img');
    cardContainer.appendChild(img);

    let title = document.createElement('p');
    title.textContent = facility.name;
    title.classList.add("facil_list_title");
    cardContainer.appendChild(title);

    let desc = document.createElement('p');
    desc.textContent = facility.desc;
    desc.classList.add('facil_list_txt');
    cardContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/group_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    img.classList.add('facil_list_icon');
    cardContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.capacity;
    desc.classList.add('facil_list_txt');
    cardContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/location_on_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    img.classList.add('facil_list_icon');
    cardContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.location;
    desc.classList.add('facil_list_txt');
    cardContainer.appendChild(desc);

    img = document.createElement('img');
    img.setAttribute("src", '../images/error_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg');
    img.classList.add('facil_list_icon');
    cardContainer.appendChild(img);

    desc = document.createElement('p');
    desc.textContent = facility.avail;
    desc.classList.add('facil_list_txt');
    cardContainer.appendChild(desc);
}

function makeFacility(data) {
    for (facility of data) {
        console.log(facility);
        createCard(facility);
    }
}

function getFacility() {
    fetch('../data/facility-info.json')
    .then(function(responce) {
        return responce.json();
    })
    .then(function(data) {
        makeFacility(data);
    }) 
    .catch(function(error) {
        console.log('error: ', error);
    });
}

window.addEventListener("load", (event) => {
    console.log(document.URL);
    getFacility();
});