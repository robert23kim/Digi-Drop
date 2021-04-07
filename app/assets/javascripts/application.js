// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require_tree .

// Fill asset id inside modal
$(document).on("click", ".button-sell", function () {
    const asset_id = $(this).data('id');
    $(".modal-body #asset_id").val(asset_id);
});

/*
    Open modal on page load if opened case before form submission. POST => redirect
    Cycle through different contents in case for a few seconds and then display final product.
*/
$(document).ready(function () {
    let added_collectible = $('#added_collectible').data('temp');

    if (added_collectible) {
        $("#caseOpenModal").modal('show');

        let cardElement = document.getElementById('content-card');
        cardElement.className = "bounce-in";

        /* SPINNING ANIMATION LOGIC. NOT IN USE FOR NOW */
        // let imgElement = document.getElementById('content-image');
        // let badgeElement = document.getElementById('content-badge');
        // let textElement = document.getElementById('content-text');
        // let case_contents = $('#case_contents').data('temp');
        // let shuffled_contents = shuffle(case_contents)
        // let index = 0;
        // function change() {
        //     imgElement.src = shuffled_contents[index].url;
        //     badgeElement.className = "badge " + shuffled_contents[index].rarity;
        //
        //     switch (shuffled_contents[index].rarity) {
        //         case 'C':
        //             badgeElement.innerHTML = "Common";
        //             break;
        //         case 'N':
        //             badgeElement.innerHTML = "Normal";
        //             break;
        //         case 'R':
        //             badgeElement.innerHTML = "Rare";
        //             break;
        //         case 'SR':
        //             badgeElement.innerHTML = "Super Rare";
        //             break;
        //     }
        //
        //     textElement.innerHTML = shuffled_contents[index].name;
        //
        //     index = ++index % shuffled_contents.length;
        // }

        // let spin = setInterval(change, 300);

        // 3s delay before spinning stops
        // setTimeout(function () {
        //     // stop spinning
        //     clearInterval(spin);

        // set final to be actual reward
        // setTimeout(function () {
        //     imgElement.src = added_collectible.url;
        //     badgeElement.className = "badge " + added_collectible.rarity;
        //
        //     switch (added_collectible.rarity) {
        //         case 'C':
        //             badgeElement.innerHTML = "Common";
        //             break;
        //         case 'N':
        //             badgeElement.innerHTML = "Normal";
        //             break;
        //         case 'R':
        //             badgeElement.innerHTML = "Rare";
        //             break;
        //         case 'SR':
        //             badgeElement.innerHTML = "Super Rare";
        //             break;
        //     }
        //
        //     textElement.innerHTML = added_collectible.name;
        // }, 600);
        //
        // }, 3000);
    }
});

/*
    Randomly shuffle contents of array
 */
function shuffle(array) {
    let currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }

    return array;
}