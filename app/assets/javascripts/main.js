
$(document).ready(function () {
   $("#login_form").validate();

   $('.datepicker').datepicker({
     format: "yyyy-mm-dd"
   });

//Get các giá trị quận của thành phố
   $('#city_select').on('change',function(){
     var self = $(this);
     $.ajax({
       url: "/api/v1/districts/return_districts_by_city_id",
       type: "GET",
       data: {
       city_id: self.find(":selected").val()
       },
       success: function(res){
          $('.render_ajax').remove();
           console.log(res.data);
          $('#district_select').append(res.data);
       }
     });
   });

function returnLogin(){
  var check = confirm("Bạn phải đăng nhập vào hệ thống");
  if (check){
    window.location = "/login"
  }
}
//trả về đăng nhập
   $('body').on('click','.return-login', function(event) {
      returnLogin();
    });

//like bài post
   $('.post-like').click(function(event){
     var self = $(this);
     $.ajax({
       url: $(this).attr("data-target"),
       type: "post",
       success: function(res){
         console.log(res);
         self.parents('.post-item').find('.view-like').html(res.data.likes +' người thích nội dung này');
         if(res.data.isLike == false){
          // self.html("Thích");
          self.removeClass("btn-primary");
          self.addClass("btn-default");
          }else{
          // self.html("Thích");
          self.removeClass("btn-default");
          self.addClass("btn-primary");
          }
        }
     });
   });

//bình luận bài post bằng click
   $('.post-comment').click(function(event) {
     var self = $(this).parents("form");
      if ($('#comment_content').val().length < 1) {
      alert("Bình luận không được để trống")
       }else {
        event.preventDefault();
        $.ajax({
          url: self.attr('action'),
          type: "post",
          data: {
            "comment[content]": $('#comment_content').val(),
            "comment[post_id]": $('#comment_post_id').val()
          },
          success: function(res){
            $('.list-comment').append(res.data);
              $('#comment_content').val("");
          }
        });
       }
    });

// hàm bình luân bài post
  function postComment(){
    if ($('#comment_content').val().length < 1) {
      alert("Bình luận không được để trống")
    }else {
     event.preventDefault();
     $.ajax({
       url: "/api/v1/comments",
       type: "post",
       data: {
         "comment[content]": $('#comment_content').val(),
         "comment[post_id]": $('#comment_post_id').val()
       },
       success: function(res){
         $('.list-comment').append(res.data);
           $('#comment_content').val("");
       }
     });
    }
  }

//bình luận bài post bằng enter
  $('body .new_comment #comment_content').keypress(function(event){
    console.log(event.which);
    if(event.which == 13) {
      event.preventDefault();
      if ($('#comment_current_user').val().length > 0) {
        postComment();
      }else{
        returnLogin();
      }
    }
  });

//delete comment
  $('.list-comment').on('click', '.delete-comment', function(event){
    var check = confirm("Bạn có muốn xóa không?");
    if (check){
      var self = $(this);
        $.ajax({
          url: "/api/v1/comments/" + self.attr('data-target'),
          type: "delete",
          success: function(res){
            if(res.success) {
              self.parents('.box-comment').remove();
            }
            else {
              alert("Không đúng người dùng");
            }
          }
        });
      }
  });

//hiện reply comment
  $('body').on('click', '.reply-comment', function(event){
    event.preventDefault();
    var self = $(this);
    if (self.parents('.box-replies').find('.open-replies').length > 0) {
      self.parents('.box-replies').find('.reply-comment').removeClass("hidden");
      self.parents('.box-replies').find('.open-replies').remove();
    }else{
      $.ajax({
        url: "/api/v1/comments/" + self.attr('data-target') + "/replies",
        type: "get",
        success: function(res){
          self.parents('.box-replies').find('.reply-comment').addClass("hidden");
          self.parents('.box-replies').find('.replies').append(res.data);

        }
      });
    }
  });

//reply comment bằng click
  $('body').on('click', '.post-reply-comment', function(event){
    event.preventDefault();
    var self = $(this);
    var content =  self.parents('.new-reply-comment').find('input').val();
    if (content){
      $.ajax({
        url: "/api/v1/comments/" + self.attr('data-target') + "/create_reply_comment",
        type: "post",
        data: {
          "reply[content]": content ,
          "reply[comment_id]": self.attr('data-target')
        },
        success: function(res){
          self.parents('.new-reply-comment').find('textarea').val('') ;
          self.parents('.open-replies').find('.list-replies').append(res.data);
        }
      });
    }else{
      alert("Bình luận không được để trống");
    }
  });

function postReply(self) {
  // var data_target = self.parents('.new-reply-comment').find('.post-reply-comment').attr('data-target');
  var data_target = self.parents('.new-reply-comment').find('.post-reply-comment').val();
  var content =  self.val();
  if (content){
    $.ajax({
      url: "/api/v1/comments/" + data_target + "/create_reply_comment",
      type: "post",
      data: {
        "reply[content]": content ,
        "reply[comment_id]": data_target
      },
      success: function(res){
        self.val('') ;
        self.parents('.open-replies').find('.list-replies').append(res.data);
      }
    });
  }else{
    alert("Bình luận không được để trống");
  }
}
// reply comment bằng enter
$('body').on('keypress', '.new-reply-comment input', function(event){
  var self = $(this);
  console.log(event.which);
  if(event.which == 13){
    event.preventDefault();
    if ( current_user ){
      postReply(self);
    }else{
      returnLogin();
    }
  }
});

//delete reply
$('body').on('click', '.delete-reply',function(event){
  var check = confirm("Bạn có muốn xóa bình luận không");
  if (check) {
    var self = $(this);
    $.ajax({
      url: "/api/v1/comments/" + self.attr('data-target')+ "/destroy_reply",
      type: "delete",
      success: function(res){
        if(res.success){
          self.parents('.box-reply').remove();
        }
      }
    });
  }
});

});
