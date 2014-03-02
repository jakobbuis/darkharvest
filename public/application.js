$(document).ready(function() {
    // Get the first repository
    get_repository();

    // Enable key handlers
    $(document).on('keyup', enact_judgement);
});

function get_repository()
{
    $.getJSON('/next', null, function(result){
        $('.name').html(result.name).attr('data-id', result.id);
        $('.description').html(result.description);
    });
}

function enact_judgement(event)
{
    console.log(event.which);
    var keycode = event.which;

    // Do nothing if another key than J, K or L is pressed
    if ([74, 75, 76].indexOf(keycode) === -1) {
        return; 
    }
    
    event.preventDefault();
    var classification = '';

    if (keycode === 74) { // J: eclipse
        classification = 'eclipse';
    }
    else if (keycode === 75) { // K: unknown
        classification = 'unknown';
    }
    else if (keycode === 76) { // L: not eclipse
        classification = 'other';
    }
    else {  // Do nothing
        return;
    }

    // Send our result
    $.ajax({
        url: '/classify',
        method: 'POST',
        data: JSON.stringify({
            id: $('h2').attr('data-id'),
            classification: classification,
        }),
        contentType: 'json',
        success: function(result) {
            get_repository();
        },
    });
}
