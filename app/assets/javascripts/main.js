
$(document).ready(function () {
   $("#login_form").validate();

   $('.datepicker').datepicker({
     format: "yyyy-mm-dd"
   });

   $('#city_select').on('change',function(){
     var self = $(this);
     $.ajax({
       url: "/api/v1/return_districts_by_city_id",
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
                <div class=" col-md-6">' + res.data.user + ': ' + res.data.content + ' </div>\
                <div class=" col-md-6"><button data-target = "' +res.data.id+' " class="btn btn-danger delete-comment">Xóa</button>  </div>\
              </li>\
            </div>');
            $('#comment_content').val("");
        }
      });
     }
    });

    $('.return-login').click(function(event) {
       var check = confirm("Bạn phải đăng nhập vào hệ thống");
       if (check){
         window.location = "/login"
       }
     });

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

});
