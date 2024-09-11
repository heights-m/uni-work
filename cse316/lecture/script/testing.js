

function fillList(itemList) {
    let toplevel = document.createElement('div');
    let newUl = document.createElement('ul');
    toplevel.classList.add('createdUl');
    itemList.map((item) => {
        let newLi = document.createElement('li');
        let liText = document.createTextNode(item); //can be added to different html elements
        newLi.appendChild(liText);       //adds textnode item as a child inside the <li> in the DOM
        newUl.appendChild(newLi);
    });
    toplevel.appendChild(newUl);
    let masterDiv = document.getElementById('main');
    masterDiv.appendChild(toplevel);
}

function clearLists() {
    const listElems = document.getElementsByClassName('createdUl');
    console.log(listElems);
    for (el of listElems) {
        console.log(el);
        el.remove();
    }
}