(function( $ ){

  $.fn.maxHeight = function() {

    var max = 0;

    this.each(function() {
      max = Math.max( max, $(this).height() );
    });

    return max;
  };
})(jQuery);

(function ($) {

    $.fn.lockDimensions = function (type) {

        return this.each(function () {

            var $this = $(this);

            if (!type || type == 'width') {
                $this.width("200px");
            }

            if (!type || type == 'height') {
                $this.height($this.height());
            }

        });

    };
})(jQuery);

(function ($) {

    $.fn.tooltip = function (options) {

        // Create some defaults, extending them with any options that were provided
        var settings = $.extend({
            'location': 'top',
            'background-color': 'blue'
        }, options);

        return this.each(function () {

            var $this = $(this);


        });

    };
})(jQuery);

$(document).ready(function () {
    $('div').tooltip({
        'location': 'left'
    });
    console.log($('div').location)
}
)