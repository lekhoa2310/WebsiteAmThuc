$(document).ready(function(){
    $('.datepicker').datepicker({
      format: "yyyy-mm-dd"
    });
  });

function validateForm_change_password(){
  var old_password = document.forms["change_password_form"]["old_password"].value;
  var new_password = document.forms["change_password_form"]["new_password"].value;
  var confirm_password = document.forms["change_password_form"]["confirm_password"].value;
  if (old_password == ""){
    alert("Old password can't be blank");
    return false;
  }
  if (new_password == ""){
    alert("New password can't be blank");
    return false;
  }
  if (confirm_password == ""){
    alert("Confirm password can't be blank");
    return false;
  }
  if(new_password != confirm_password ){
    alert("Confirm password  doesn't match New password");
    return false;
  }
}
