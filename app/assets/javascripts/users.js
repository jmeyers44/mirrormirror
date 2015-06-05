$(document).ready(function(){
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

  $(function() {
    var availableTags = 
    $('tbody > tr > td a').map(function(){return $(this).text();}).get();
    // $( "#tags" ).autocomplete({
    //   source: availableTags
    // });
  });
  
  $( "#tags" ).keyup(function(){ $('.song-row:not(:contains('+$('#tags').val()+'))').hide(); });
  $( "#tags" ).keyup(function(){ $('.song-row:contains('+$('#tags').val()+')').show(); });

  setInterval(function(){if($('#tags').val()=== ""){
    $('.song-row').show();
  }
},40);


  
})
