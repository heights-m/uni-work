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
