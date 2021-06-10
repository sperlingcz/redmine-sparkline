const sparkline_selector = '.done_ratio_sparkline';

function draw() {
    $(sparkline_selector).sparkline('html', {enableTagOptions: true});
};

function move(tag, targetSelector) {
    $(sparkline_selector)
    //    .children()
        .each(function (i, v) {
        let elem = document.createElement(tag);
        elem = $(elem);

        var attributes = $(v).prop("attributes");
        $.each(attributes, function() {
            elem.attr(this.name, this.value);
        });

        $(elem).insertAfter($(targetSelector(v)));
    });
};



const issues_list_selector = function (v) {
    return "tr[id='issue-" + $(v).attr("issueid") + "'] td.done_ratio"
};

const issues_show_selector = function (v) {
    return ".progress.attribute .percent"
};

function issues_list_sparkline() {
    $("th.done_ratio").attr('colspan', 2);
    move("td", issues_list_selector);
    draw();
}

function issues_show_sparkline() {
    move("div", issues_show_selector);
    draw();
}