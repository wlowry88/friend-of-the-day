$(function(){
  $(".edit_friend_form").hide();
  $("#normal_friends_list").hide();
  $(".edit_number_form").hide();

  $(".edit-friend-button").on("click", function(e){
    e.preventDefault();
    $(this).parent().find(".edit_friend_form").first().css("visibility", "visible").slideToggle();
  });

  $(".settings_button").on("click", function(e){
  	e.preventDefault();
  	$(".edit_number_form").css("visibility", "visible").slideToggle();
  });

  $("#show_friends_button").on("click", function(e){
  	e.preventDefault;
  	$("#normal_friends_list").css("visibility", "visible").slideToggle();
  });
});