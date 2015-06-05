$(document).ready(function(){

  // $('.play').on('click', function(){
    // $('.feed-me').find('.embedly-card').on("load", function(){
    //   // debugger;
    // })
//   })
// });

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
    video_index+=1;
    $('#links_array').attr("class",video_index);

    links_obj = $.parseJSON($('#links_array').html())

    var key = Object.keys(links_obj[video_index])
    

    $('#player').html("<a class='embedly-card' href="+links_obj[video_index][key]+"></a>")

    $.post(window.location.pathname+'/links/'+key,{vote: "downvote"})
  })
})
