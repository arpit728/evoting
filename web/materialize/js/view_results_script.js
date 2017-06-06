function indicate_winner() {
    vote_count_cont1 = document.getElementById("votes_cont1").innerHTML;
    vote_count_cont2 = document.getElementById("votes_cont2").innerHTML;
    vote_count_cont3 = document.getElementById("votes_cont3").innerHTML;
    max = Math.max(vote_count_cont1, vote_count_cont2, vote_count_cont3);
    if (max == vote_count_cont1) {
        document.getElementById("images_cell_cont1").className += "winner_cell_indicator";
        document.getElementById("badge_cont1").className += "visible";
    } else if (max == vote_count_cont2) {
        document.getElementById("images_cell_cont2").className += "winner_cell_indicator";
        document.getElementById("badge_cont2").className += "visible";
    } else {
        document.getElementById("images_cell_cont3").className += "winner_cell_indicator";
        document.getElementById("badge_cont3").className += "visible";
    }
}