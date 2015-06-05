$(document).ready(function(){
  $('#upvote').on('click',function(event){
    event.preventDefault();
    var link_id = $('#player').attr("class")
    // var song_id = $('')
    $.post(window.location.pathname+'/links/'+link_id,{vote: "upvote"})
  })

  $('#downvote').on('click',function(event){
    event.preventDefault();
    var link_id = $('#player').attr("class")
    $.post(window.location.pathname+'/links/'+link_id,{vote: "downvote"})
  })
})
