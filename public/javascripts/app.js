$(document).ready(function() {
    setInterval(function() {
        $.get("/items",
            function (result) {
                items = JSON.parse(result);
                for (i = 0; i < items.length - 1; i++) {
                    $("#" + items[i]['html_identifier']).html(items[i]['content']);
                }
            });
    }, 5000);
});