$("[data-parsley-group='signUp']").parsley();

$.listen('parsley:field:error', function (ParsleyField) {
    $(".not-valid-cross[data-id='" + ParsleyField.$element.attr("data-ref") + "']").show();
    $(".valid-tick[data-id='" + ParsleyField.$element.attr("data-ref") + "']").hide();
});
$.listen('parsley:field:success', function (ParsleyField) {
    $(".not-valid-cross[data-id='" + ParsleyField.$element.attr("data-ref") + "']").hide();
    $(".valid-tick[data-id='" + ParsleyField.$element.attr("data-ref") + "']").show();
});

function validateThis() {

    if ($('form').parsley().isValid({ group: "signUp" })) {
        //return;
    }
    else {
        var parsleyForm = $('form').parsley();
        for (var i in parsleyForm.fields) {
            if (parsleyForm.fields[i].validationResult === true) {
                $(".valid-tick[data-id='" + parsleyForm.fields[i].$element.attr("data-ref") + "']").show();
                $(".not-valid-cross[data-id='" + parsleyForm.fields[i].$element.attr("data-ref") + "']").hide();
            }
            else {
                $(".not-valid-cross[data-id='" + parsleyForm.fields[i].$element.attr("data-ref") + "']").show();
                $(".valid-tick[data-id='" + parsleyForm.fields[i].$element.attr("data-ref") + "']").hide();
            }
        }
    }
};



//$(function () {
//    $('#ct-101').parsley().on('field:validated', function () {
//        var ok = $('.parsley-error').length === 0;
//        if(!ok){
//            alert("yeap");
//        }
//        else{
//            alert("error");
//        }

//    })
//    .on('form:submit', function () {
//        return false; // Don't submit form for this demo
//    });
//});