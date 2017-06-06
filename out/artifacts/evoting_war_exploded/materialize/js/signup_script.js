function only_mobile_number() {
    inp = document.getElementById("mobile_number").value;
    if(isNaN(inp)) {
        document.getElementById("mobile_number").value = "";
    }
}

function only_letters(x) {
    inp = document.getElementById(x).value;
    if(!/[a-z]/.test(inp.toLowerCase())) {
    	document.getElementById(x).value="";
    }
}