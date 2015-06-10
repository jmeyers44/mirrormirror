$(document).ready(function(){
  
  $(document).ready(function(){    
  $('.mm-logo').delay(100).css({'opacity':0}).animate({'opacity':1}, 2000);
  
  });


  $('#upvote').on('click',function(event){
    event.preventDefault();
    var video_index = parseInt($('#links_array').attr("class"));
    links_obj = $.parseJSON($('#links_array').html())

    var key = Object.keys(links_obj[video_index])
    $.post(window.location.pathname+'/links/'+key,{vote: "upvote"})
  })

  $('#downvote').on('click',function(event){
    event.preventDefault();
    var video_index = parseInt($('#links_array').attr("class"));
    var new_video_index = video_index + 1;
    $('#links_array').attr("class",new_video_index);

    links_obj = $.parseJSON($('#links_array').html())

    var oldKey = Object.keys(links_obj[video_index])
    var newKey = Object.keys(links_obj[new_video_index])

    $('#player').html("<a class='embedly-card' href="+links_obj[new_video_index][newKey]+"></a>")
    $.post(window.location.pathname+'/links/'+oldKey,{vote: "downvote"})
  })

  
  // $('.progress-bar').ready(function(){
  //   var speed = 11;//seconds
  //   $("#progress-bar").css("animation", "load "+speed+"s");
  //   $("#progress-bar").css("animation-fill-mode", "forwards");
  //   // alert("workd!");
  // })


  $(function() {
    var availableTags = 
    $('tbody > tr > td a').map(function(){return $(this).text();}).get();
    // $( "#tags" ).autocomplete({
    //   source: availableTags
    // });
  });

  jQuery.expr[":"].Contains = jQuery.expr.createPseudo(function(arg) {
    return function( elem ) {
        return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});
  
  $( "#tags" ).keyup(function(){ $('.song-row:not(:Contains('+$('#tags').val()+'))').hide(); });
  $( "#tags" ).keyup(function(){ $('.song-row:Contains('+$('#tags').val()+')').show(); });

  setInterval(function(){if($('#tags').val()=== ""){
    $('.song-row').show();
  }
},40);


  
})
