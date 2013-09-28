PERMANENT_URL_PREFIX = '/stylesheets/';

$(document).keypress(function(e) {
    var keyCode = (e.keyCode ? e.keyCode : e.which);
    if (keyCode == 114) { // r - Run code
        var pre = $('article.current pre.executable')
        $.post('/eval', { type: pre.attr('class'), code: pre.text() }, function (res) {
            var decoded = $("<div/>").html(res).text();
            pre.notify(decoded, {
                className: '',
                showDuration: 0
            });
        });
    }
});
