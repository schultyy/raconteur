window.App = {};
$(document).ready(function() {
    $('.slide').hide();
    $('.slide').first().show();
    window.App.currentSlide = 0;
    window.App.slideCount = $('.slide').length;
});
$(document).keypress(function(event) {
    switch(event.keyCode) {
        case 37: {
            //left
            if(window.App.currentSlide > 0) {
                $('.slide:eq('+ window.App.currentSlide.toString() +')').hide();
                window.App.currentSlide--;
                $('.slide:eq('+ window.App.currentSlide.toString() +')').show();
            }
            break;
        }
        case 39: {
            //right
            if(window.App.currentSlide + 1 < window.App.slideCount) {
                $('.slide:eq('+ window.App.currentSlide.toString() +')').hide();
                window.App.currentSlide++;
                $('.slide:eq('+ window.App.currentSlide.toString() +')').show();
            }
            break;
        }
    }
});
