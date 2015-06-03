$(document).ready(function(){

  $('button').click(function(){
    var file_path = $('#temp_file').text();
  $.post("/users/parse",{file_path: file_path},function(){})
  })

})

  //   if($('body').is('#users.show')){
  //   var file_path = $('#temp_file').text();
  // $.get("/users/parse",{file_path: file_path},function(){})
  // }