$(function(){
    try {
    var pageTracker = _gat._getTracker("UA-10411691-1");
    pageTracker._trackPageview();
    } catch(err) {}

    $("#menu ul").kwicks({
         max : 205,
         spacing : 1 
     });

    $("#menu ul li").click(function(){
      window.location = $(this).children()[0].href;
    });

    $("#portfolio-images a").slimbox(
      {
        counterText: slimbox_counter_text, 
        captionAnimationDuration: 1700
      }, 

      function(el){
        return [el.href, el.title, $(el).parents('li').next('div').html()]; 
      }
    );

});

