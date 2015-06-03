$("#myaction").click(function(){
      //write your animation code here

      $.ajax({
        url: "http://localhost:3000/home#load",
        dataType: "json",
        type: "POST",
        processData: false,
        contentType: "application/json",
        data: yourdata
        success: function(){
             //stop your animation here
             //send user to page of song lists
        }
      })
    });