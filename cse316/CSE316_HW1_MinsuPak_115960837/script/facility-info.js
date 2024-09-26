const CARDS_CONTAINER = document.getElementsByClassName('flex_container')[0];
const svgarr = ['../images/group_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/location_on_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/error_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg']

function makeFacility(data) {
    for (facility of data) { //iterates through all the facilities in facility array
        createCard(facility, CARDS_CONTAINER, svgarr);
    }
}

function getFacility() {
    fetch('../data/facility-info.json') //get array of facility info from JSON file
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
    getFacility();
});