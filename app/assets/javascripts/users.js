$(document).ready(function(){
    $('.play').click(function(){
      $('#player').removeClass('hide').addClass('show');
      // $('.card').removeClass('card video');
    });
    // $('#player').data('size','big');

    //   $(window).scroll(function(){
    //     if($(document).scrollTop() > 0)
    //     {

    //       if($('#player').data('size') == 'big')
    //       {
    //           $('#player').data('size','small');
    //           $('#player').stop().animate({
    //               height:'150px'
    //           },600);
    //       }
    //     }

      // else

      //   {
      //     if($('#player').data('size') == 'small')
      //     {
      //         $('#player').data('size','big');
      //         $('#player').stop().animate({
      //             height:'100px'
      //         },600);
      //     }  
      //   }
      // });

});

