let facil_arr = null;
let current_facil = 0;
const FACIL_SELECT = document.getElementById('facil-select');
let reservations = [];
const svgarr = ['../images/group_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/location_on_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/error_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg']

function getFacility() { //gets facility info array
    fetch('../data/facility-info.json')
    .then(function(responce) {
        return responce.json();
    })
    .then(function(data) {
        facil_arr = data;
        createCard(facil_arr[0], document.getElementById('card-cont'), svgarr); //create starting card - gym
    }) 
    .catch(function(error) {
        console.log('error: ', error);
    });
}

function facilChanged(selectElem) {
    updateCard(selectElem.selectedIndex);
}

//updates facility shown when new facility selected
function updateCard(index) {
    current_facil = index;
    let card = document.getElementsByClassName("facil_container")[0]; //only 1 element of this class
    let cardChilds = card.childNodes;
    //sets new info/values using the facility info array
    cardChilds[0].setAttribute("src", facil_arr[index][6]);
    cardChilds = cardChilds[1].childNodes;
    cardChilds[0].textContent = facil_arr[index][0];
    cardChilds[1].textContent = facil_arr[index][1];
    cardChilds[3].textContent = facil_arr[index][2];
    cardChilds[5].textContent = facil_arr[index][3];
    cardChilds[7].textContent = facil_arr[index][4];
}

window.addEventListener("load", (event) => {
    getFacility();
});

function checkValidRes(res) {
    if (!facil_arr[current_facil][5] && !res[5]) { //checking affiliation is valid
        return false;
    }
    let today = new Date();
    let curr_day = today.getDate();
    let curr_month = today.getMonth() + 1;
    let curr_year = today.getFullYear();
    let date = res[2].split("-");
    if (date[0] < curr_year || (date[1] < curr_month && date[0] == curr_year) || (date[2] < curr_day && date[1] == curr_month)) {
        return false;
    }
    if (res[3] > facil_arr[current_facil][2]) { //checking capacity limit
        return false;
    }
    return true;
}

function updateReservations(res) {
    let reservations = JSON.parse(localStorage.getItem('reservations'));
    if (reservations == null) { //if there are no reservations in localStorage
        reservations = [];
    }
    reservations.push(res);
    localStorage.setItem('reservations', JSON.stringify(reservations));
}

//called on submit
function saveReservation() {
    const new_res = new Array(7);

    ///get data from form
    new_res[0]= facil_arr[current_facil][0]; //get current facility's name
    new_res[2] = document.getElementById('datetbu').value;
    new_res[3] = +document.getElementById('numppl').value;
    if (document.getElementById('afil-yes').checked) {
        new_res[5] = true;
    } else {
        new_res[5] = false;
    }
    new_res[1] = document.getElementById('purpose').value;
    new_res[4] = facil_arr[current_facil][3]; //get current facility's location
    new_res[6] = facil_arr[current_facil][6]; //get current facility's image path

    if (!checkValidRes(new_res)) { //check conditions are valid
        window.alert("Cannot reserve");
    } else {
        updateReservations(new_res);
        window.alert("Reservation made");
        document.getElementById('res-form').reset();
    }
}