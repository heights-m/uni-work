let facil_arr = null;
const FACIL_SELECT = document.getElementById('facil_select');

function getFacility() {
    fetch('../data/facility-info.json')
    .then(function(responce) {
        return responce.json();
    })
    .then(function(data) {
        facil_arr = data;
        console.log(facil_arr);
        createCard(facil_arr[0], document.getElementById('card-cont'));
    }) 
    .catch(function(error) {
        console.log('error: ', error);
    });
}

function updateCard(index) {
    let card = document.getElementsByClassName("facil_container")[0];
    console.log(card);
    let facility = facil_arr[FACIL_SELECT.selectedIndex];
    let cardChilds = card.childNodes;
    console.log(cardChilds);
}

window.addEventListener("load", (event) => {
    console.log(document.URL);
    getFacility();
    updateCard
});