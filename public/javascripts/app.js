$(document).ready(function() {
    setInterval(function() {
        $.get("/items",
            function (result) {
                items = JSON.parse(result);
                console.log(items);
                for (i = 0; i < items.length - 1; i++) {
                    console.log(items[i]);
                    console.log(items[i]['html_identifier']);
                    $("#" + items[i]['html_identifier']).html(items[i]['content']);
                }
            });
    }, 5000);
});