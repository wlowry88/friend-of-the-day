$(function(){
  $(".edit_friend_form").hide();
  $(".edit-friend-button").on("click", function(e){
    e.preventDefault();
    $(this).parent().find(".edit_friend_form").first().slideToggle();
  })

});