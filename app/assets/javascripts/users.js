$(document).ready(function(){
  
  // String.prototype.trimToLength = function(m) {
  // return (this.length > m) 
  //   ? jQuery.trim(this).substring(0, m).split(" ").slice(0, -1).join(" ") + "..."
  //   : this;
  // };

  $(document).ready(function(){    
  $('.mm-logo-users').delay(100).css("visibility","visible").css({'opacity':0}).animate({'opacity':1}, 2000);
  });


  $('.playbutton').on('click',function(){
    var $song = $(this).parent().parent()
    current_song_id = $song.attr("id")
    $('#current_song').text(current_song_id)
    var count_text = $song.children('#play_count').text();
    var number = parseInt(count_text);
    number += 1;
    $(this).parent().parent().children('#play_count').text(number)
  });


  $('#upvote').on('click',function(event){
    event.preventDefault();
    var video_index = parseInt($('#links_array').attr("class"));
    var links_obj = $.parseJSON($('#links_array').html())
    var user_id = $('#user_id').text()

    var key = Object.keys(links_obj[video_index])
    $.ajax({
      url: '/users/'+user_id+'/links/'+key,
      type: 'POST',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {vote: "upvote"}
    })
  })

  $('#downvote').on('click',function(event){
    event.preventDefault();
    var video_index = parseInt($('#links_array').attr("class"));
    var new_video_index = video_index + 1;
    $('#links_array').attr("class",new_video_index);

    var links_obj = $.parseJSON($('#links_array').html())
    var user_id = $('#user_id').text()

    var oldKey = Object.keys(links_obj[video_index])
    var newKey = Object.keys(links_obj[new_video_index])

    $('#player').html("<a class='embedly-card' href="+links_obj[new_video_index][newKey]+"></a>")


    $.ajax({
      url: '/users/'+user_id+'/links/'+oldKey,
      type: 'POST',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {vote: "downvote"}
    })

    function getCard(){
      $('iframe.embedly-card').each(function(){
        // Create the player.
        var player = new playerjs.Player(this);
        // Wait for the player to be ready before attaching more event.
        player.on('ready', function(){  
          player.play();
        });

        player.on('ended', function(){
        // Code that needs to find next sibling in table list and start autoplaying.
          var song_id = $('#current_song').text();
          var song_id_int = parseInt(song_id);
          song_id_int += 1;
          $('#'+song_id_int+'.song-row > td > a > img').click()
        })
      });
    }
    setTimeout(getCard, 1500);
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

  function makeUpdates(results){
    var length = 40;
    var userId = $('#user_id').html();
    var songArray = results["song_array"]
    for (var i = 0, len = songArray.length; i < len; i++) {
    var songName = songArray[i]["song_name"].substring(0,length);
    var albumName = songArray[i]["album_name"].substring(0,length);
    var artistName = songArray[i]["artist_name"].substring(0,length);
    var songId = songArray[i]["song_id"]
    var lastRowId = String(parseInt($('table tr:last').attr('id')) + 1);
    $('table tbody:last-child').append("<tr id = '" + lastRowId + "' class='song-row'><td><a href=/users/" + userId + "/play/" + songId + " data-remote='true' class='playbutton'><img class='play' height='30' src='/assets/icons/play-faf3d4e83e69e55282a5902d2bb7167d887a88cf1be15e16410f5629a63b47bb.png' alt='Play faf3d4e83e69e55282a5902d2bb7167d887a88cf1be15e16410f5629a63b47bb'></a></td><td><a href='#'>" + songName + "</a></td><td>" + artistName + "</td><td>" + albumName + "</td><td id='play_count'>0</td></tr>");
    
    }
      
    // })
  }

    if($('.bottomFill').length == 1){setInterval(function(){
    var songCount = $('.song-row').length
    var user_id = $('#user_id').html();
    $.ajax({
      type: 'POST',
      url: '/users/'+user_id+'/load_more_songs',
      data: {user_id: user_id, song_count: songCount},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(results){
        makeUpdates(results);
      },
      dataType: 'JSON'
    })
  },500)
  }
})
