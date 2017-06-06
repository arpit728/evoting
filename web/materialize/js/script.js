$( document ).ready(function(){
    $(".button-collapse").sideNav();
})

rand_list = []
function grid_gen() {

    while (rand_list.length != 4) {
        a = Math.floor(Math.random() * (7 - 1 + 1) + 0);
        if (!rand_list.includes(a))
            rand_list.push(a)
    }
    document.getElementById("grid_label0").innerHTML = rand_list[0];
    document.getElementById("grid_label1").innerHTML = rand_list[1];
    document.getElementById("grid_label2").innerHTML = rand_list[2];
    document.getElementById("grid_label3").innerHTML = rand_list[3];
    
}

function compute_grid_string() {
    grid_string = new String();
    for (i = 0; i < 8; i++) {
        if(!rand_list.includes(i))
            grid_string += 0;
        else
            grid_string += document.getElementById(rand_list.indexOf(i)).value;
    }
//    alert(grid_string);
    document.getElementById("hidden_field").value = grid_string;
    alert(document.getElementById("hidden_field").value);
}