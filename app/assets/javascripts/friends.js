$(function(){
  $(".edit_friend_form").hide();
  $("#normal_friends_list").hide();
  $(".edit_number_form").hide();
  $(".friend_of_the_day").hide();
  $("#new_friend_form").hide();

  $(".close_friends_list").on("click", ".edit-friend-button", function(e){
    e.preventDefault();
    $(this).parent().find(".edit_friend_form").first().css("visibility", "visible").slideToggle();
  });
  $("#normal_friends_list").on("click", ".edit-friend-button", function(e){
    e.preventDefault();
    $(this).parent().find(".edit_friend_form").first().css("visibility", "visible").slideToggle();
  });

  $(".settings_button").on("click", function(e){
  	e.preventDefault();
  	$(".edit_number_form").css("visibility", "visible").slideToggle();
  });

  $("#show_friends_button").on("click", function(e){
  	e.preventDefault;
    $("#normal_friends_list").css("visibility", "visible").toggle();
    $("body").scrollTo("#show_friends_button", {duration: 1000});
  });

  $(".friend_of_the_day").css("visibility", "visible").fadeIn(1500);

  $("#phone_submit").on("click", function(e){
    confirm("Are you sure you want to submit your number?");
  });
  $("#phone_edit").on("click", function(e){
    e.preventDefault();
    confirm("Are you sure you want to edit your number?");
  });

  $(".new_friend_button").on("click", function(e){
    e.preventDefault();
    $("#new_friend_form").css("visibility", "visible").slideToggle();

  })
});