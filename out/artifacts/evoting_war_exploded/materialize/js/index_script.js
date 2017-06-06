$( document ).ready(function(){
    $(".button-collapse").sideNav();
})

rand_list = []
function grid_gen() {
    while (rand_list.length != 4) {
        a = Math.floor(Math.random() * (8) + 1);
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
    for (i = 1; i < 8; i++) {
        if(!rand_list.includes(i))
            grid_string += 0;
        else
            grid_string += document.getElementById(rand_list.indexOf(i)+1).value;
    }
    console.log(grid_string);
    document.getElementById("grid").value = grid_string;
}

function only_numbers(x) {
    inp = document.getElementById(x).value;
    if(isNaN(inp)) {
    	document.getElementById(x).value="";
    }
}