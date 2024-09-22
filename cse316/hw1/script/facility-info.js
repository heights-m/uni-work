const CARDS_CONTAINER = document.getElementById('flex_container');

function makeFacility(data) {
    for (facility of data) {
        console.log(facility);
        createCard(facility, CARDS_CONTAINER);
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