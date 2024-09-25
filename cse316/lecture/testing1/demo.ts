let a = 5; //typescript can infer types -> this is valid

let b: number = 5;
                        //return type num OR str
function kgToLbs(weight:number | string, c?: number) : number {
    if (typeof(weight) === 'number') {
        return weight * 2.2;
    } else {
        return parseInt(weight) * 2.2;
    }
}

let c : [number, string] = [1, "mrw"];
c.push(2, "meow");

type Draggable = {
    drag: {} => void;
}

type Resizable = {
    resize: {} => void;
}

type UIComponent = Draggable & Resizable;