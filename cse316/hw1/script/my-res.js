const MAIN_CONTENT = document.getElementById('main_content');
const CARDS_CONTAINER = document.getElementsByClassName('flex_container')[0];
const svgarr = ['../images/event_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/group_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg', '../images/location_on_24dp_E8EAED_FILL1_wght400_GRAD0_opsz24.svg'];

window.addEventListener("load", (event) => {
    let reservations = JSON.parse(localStorage.getItem('reservations'));
    if (reservations == null) {
        let no_res_txt = document.createElement('h1');
        no_res_txt.textContent = "No Reservation Yet";
        MAIN_CONTENT.appendChild(no_res_txt);
    } else {
        for (card of reservations) {
            createCard(card, CARDS_CONTAINER, svgarr);
        }
    }
});