
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
         self.parents('.post-item').find('.view-like').html(res.data.likes);
         if(res.data.isLike == false)
          self.html("Thích");
         else
          self.html("Không thích");
       }
     });
   });

//bình luận bài post bằng click
   $('.post-comment').click(function(event) {
     if ($('#comment_content').val().length < 1) {
    alert("Bình luận không được để trống")
     }else {
      event.preventDefault();
      $.ajax({
        url: "/comments",
        type: "post",
        data: {
          "comment[content]": $('#comment_content').val(),
          "comment[post_id]": $('#comment_post_id').val()
        },
        success: function(res){
          $('.list-comment').append(
            '<div class="comment-item"> \
              <li class="box-comment margin_bottom_20 col-md-12"> \
                <div class=" col-md-6"><span class="text-primary">' + res.data.user + ': </span> ' + res.data.content + ' \
                  <div class=" col-md-12 margin_bottom_20 box-replies"> \
                    <a class="reply-comment" data-target="'+ res.data.id+'" >trả lời</a>\
                    <div class="replies"></div>\
                  </div>    \
                </div>\
                <div class=" col-md-6"><button data-target = "' +res.data.id+' " class="btn btn-danger delete-comment">Xóa</button>  </div>\
              </li>\
            </div>');
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
       url: "/comments",
       type: "post",
       data: {
         "comment[content]": $('#comment_content').val(),
         "comment[post_id]": $('#comment_post_id').val()
       },
       success: function(res){
         $('.list-comment').append(
           '<div class="comment-item"> \
             <li class="box-comment margin_bottom_20 col-md-12"> \
               <div class=" col-md-6"> <span class="text-primary">' + res.data.user + ':</span> ' + res.data.content + ' \
                 <div class=" col-md-12 margin_bottom_20 box-replies"> \
                   <a class="reply-comment" data-target="'+ res.data.id+'" >trả lời</a>\
                   <div class="replies"></div>\
                 </div>    \
               </div>\
               <div class=" col-md-6"><button data-target = "' +res.data.id+' " class="btn btn-danger delete-comment">Xóa</button>  </div>\
             </li>\
           </div>');
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
      postComment();
    }
  });

//delete comment
  $('.list-comment').on('click', '.delete-comment', function(event){
    var check = confirm("Bạn có muốn xóa không?");
    if (check){
      var self = $(this);
        $.ajax({
          url: "/comments/" + self.attr('data-target'),
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
      self.parents('.box-replies').find('.open-replies').remove();
    }else{
      $.ajax({
        url: "/api/v1/comments/" + self.attr('data-target') + "/replies",
        type: "get",
        success: function(res){
          self.parents('.box-replies').find('.replies').append(res.data);
        }
      });
    }
  });

//reply comment bằng click
  $('body').on('click', '.post-reply-comment', function(event){
    event.preventDefault();
    var self = $(this);
    var content =  self.parents('.new-reply-comment').find('textarea').val();
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
          self.parents('.open-replies').find('.list-replies').append(
            '<div class=" col-md-12 margin_bottom_10 box-reply"> \
              <div class="col-md-10"> \
                <span class="text-primary text-strong">'+res.data.user+':</span> '+res.data.content+'\
              </div>\
              <div class="col-md-2 ">\
                <button data-target="'+ res.data.id+'" class="btn btn-danger delete-reply"  >Xóa</button>\
              </div>\
            </div> \
          ');
        }
      });
    }else{
      alert("Bình luận không được để trống");
    }

  });

// reply comment bằng enter
$('body').on('keypress', '.new-reply-comment textarea', function(event){
  var self = $(this)
  console.log(event.which);
  if(event.which == 13){

    event.preventDefault();
    var data_target = self.parents('.new-reply-comment').find('.post-reply-comment').attr('data-target') ;
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
          self.parents('.open-replies').find('.list-replies').append(
            '<div class=" col-md-12 margin_bottom_10 box-reply"> \
              <div class="col-md-10"> \
                <span class="text-primary text-strong">'+res.data.user+':</span> '+res.data.content+'\
              </div>\
              <div class="col-md-2 ">\
                <button data-target="'+ res.data.id+'" class="btn btn-danger delete-reply"  >Xóa</button>\
              </div>\
            </div> \
          ');
        }
      });
    }else{
      alert("Bình luận không được để trống");
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
