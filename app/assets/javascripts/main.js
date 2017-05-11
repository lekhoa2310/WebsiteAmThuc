
$(document).ready(function () {
   $("#login_form").validate();

   $('.datepicker').datepicker({
     format: "yyyy-mm-dd"
   });

   check_notication();
   setInterval(function(){ check_notication(); }, 10000);

   function check_notication() {
    $.ajax({
      url: "/api/v1/notifications/check_notification",
      type: "GET",
      success: function(res){
         var noti = res.data.noti;
         var noti_user = res.data.noti_user;
         var noti_restaurant = res.data.noti_restaurant;
         var restaurant_hash = res.data.restaurant_hash;
         if (noti != 0) {
           $('.notification').find('.number_notification').remove();
           $('.notification').append('<span class="number_notification">'+noti+'</span>');
           $('.notification_ul').find('li').remove();

           if(noti_user != 0){
             $('.notification_ul').append('<li> <a href="/dashboard/orders/orders_shipping_user">'+ noti_user +' đơn hàng được chấp nhận</a> </li>');
           }
           if(noti_restaurant != 0){
             for (var i = 0; i < restaurant_hash.length; i++) {
               $('.notification_ul').append('<li> <a href="/dashboard/restaurants/'+restaurant_hash[i].id+'/orders/orders_pending"> '+ restaurant_hash[i].name +' có '+restaurant_hash[i].num +' đặt hàng</a> </li>');
             }
           }
         }
      }
    });
  };

   setTimeout(function(){
      $('body .alert').remove();
    }, 2000);
   //sidebar
  //  $(function(){
   //
  //  	$('#slide-submenu').on('click',function() {
  //          $(this).closest('.list-group').fadeOut('slide',function(){
  //          	$('.mini-submenu').fadeIn();
  //          });
   //
  //        });
   //
  //  	$('.mini-submenu').on('click',function(){
  //          $(this).next('.list-group').toggle('slide');
  //          $('.mini-submenu').hide();
  //  	})
  //  })


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

  //  $('body #city_select_find_restaurant').on('change',function(){
  //    var self = $(this);
  //    $.ajax({
  //      url: "/api/v1/restaurants/find_restaurants_by_city",
  //      type: "GET",
  //      data: {
  //      city_id: self.find(":selected").val()
  //      },
  //      success: function(res){
  //         $('body').html(res.data);
  //      }
  //    });
  //  });

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
   $('body ').on('click', '.post-like',function(event){
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
  //  $('.post-comment').click(function(event) {
  //    var self = $(this).parents("form");
  //     if ($('#comment_content').val().length < 1) {
  //     alert("Bình luận không được để trống")
  //      }else {
  //       event.preventDefault();
  //       $.ajax({
  //         url: self.attr('action'),
  //         type: "post",
  //         data: {
  //           "comment[content]": $('#comment_content').val(),
  //           "comment[post_id]": $('#comment_post_id').val()
  //         },
  //         success: function(res){
  //           $('.list-comment').append(res.data);
  //             $('#comment_content').val("");
  //         }
  //       });
  //      }
  //   });

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
  // $('body').on('click', '.post-reply-comment', function(event){
  //   event.preventDefault();
  //   var self = $(this);
  //   var content =  self.parents('.new-reply-comment').find('input').val();
  //   if (content){
  //     $.ajax({
  //       url: "/api/v1/comments/" + self.attr('data-target') + "/create_reply_comment",
  //       type: "post",
  //       data: {
  //         "reply[content]": content ,
  //         "reply[comment_id]": self.attr('data-target')
  //       },
  //       success: function(res){
  //         self.parents('.new-reply-comment').find('textarea').val('') ;
  //         self.parents('.open-replies').find('.list-replies').append(res.data);
  //       }
  //     });
  //   }else{
  //     alert("Bình luận không được để trống");
  //   }
  // });

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

//delete review
// $('body').on('click', '.delete-review',function(event){
//   var check = confirm("Bạn có muốn xóa đánh giá không");
//   if (check) {
//     var self = $(this);
//     $.ajax({
//       url: "/restaurants/"+ self.attr('data-restaurant')+  "/reviews/" + self.attr('data-review'),
//       type: "delete",
//       success: function(res){
//         if(res.success){
//           self.parents('.box-review').remove();
//         }
//       }
//     });
//   }
// });
//chọn đồ ăn muốn đặt
$('.box_foods_index').on('click', '.choose-food', function(event){
  var self = $(this);
  $.ajax({
    url: "/api/v1/carts/" + self.attr('data-restaurant')+ "/choose_food",
    type: "post",
    data: {
      "food_id": self.attr('data-food')
    },
    success: function(res){
      if(res.success){
        self.parents('.btn-choose-food').append('\
          <button class="btn btn-default cancel-food" data-restaurant="'+res.data.restaurant_id+'" data-food="'+res.data.food_id  +'">Hủy chọn </button>\
        ');
        self.remove();
        $('.cart .foods-of-order').append(
        '<div class="row">\
          <div class=" col-md-12 food_of_order food'+ res.data.food_id+'">\
            <div class="col-md-4 ">\
              <p>'+ res.data.food_name+'</p>\
            </div>\
            <div class="col-md-4 change-quantity ">\
              <p><span data-restaurant="'+ self.attr('data-restaurant') +'" data-food= "'+ res.data.food_id+'" class="icon-plus glyphicon glyphicon-plus txt-green"></span> <span class="text-strong quantiy ">1</span> <span data-restaurant="'+ self.attr('data-restaurant') +'" data-food= "'+ res.data.food_id+'"  class="icon-minus glyphicon glyphicon-minus"></span></p>\
            </div>\
            <div class="col-md-4 ">\
              <p>'+res.data.food_price+'</p>\
            </div>\
          </div>\
        </div>\
        ');
        $('#total').html(res.data.total);
      }
    }
  });
});
//tăng số lượng
$('body').on('click', '.icon-plus', function(event){
  var self = $(this);
  $.ajax({
    url: "/api/v1/carts/"+ self.attr('data-restaurant')+"/increase_quantity",
    type: "post",
    data: {
      "food_id": self.attr('data-food')
    },
    success: function(res){
       self.parents('.change-quantity').find('.quantiy').html(res.data.food_quantity);
      $('body').find('#total').html(res.data.total);
    }
  })
});

//giảm số lượng
$('body').on('click', '.icon-minus', function(event){
  var self = $(this);
  $.ajax({
    url: "/api/v1/carts/"+ self.attr('data-restaurant')+"/decrease_quantity",
    type: "post",
    data: {
      "food_id": self.attr('data-food')
    },
    success: function(res){
      if (res.data.food_quantity == 0) {
        $('.cart .foods-of-order .food'+res.data.food_id+'').remove();
        $('#total').html(res.data.total);
        $('.box_foods_index'+res.data.food_id+'').find('.btn-choose-food').append('\
          <button class="btn btn-danger choose-food" data-restaurant="'+res.data.restaurant_id+'" data-food="'+res.data.food_id+'">Thêm vào giỏ </button>\
        ');
        $('.box_foods_index'+res.data.food_id+'').find('.btn-choose-food .cancel-food').remove();
      }
      self.parents('.change-quantity').find('.quantiy').html(res.data.food_quantity);
      $('body').find('#total').html(res.data.total);
    }
  })
});

//Hủy món
$('.box_foods_index').on('click', '.cancel-food', function(event){
  var self = $(this);
  $.ajax({
    url: "/api/v1/carts/" + self.attr('data-restaurant')+ "/cancel_food",
    type: "post",
    data: {
      "food_id": self.attr('data-food')
    },
    success: function(res){
      if(res.success){
        self.parents('.btn-choose-food').append('\
          <button class="btn btn-danger choose-food" data-restaurant="'+res.data.restaurant_id+'" data-food="'+res.data.food_id+'">Thêm vào giỏ </button>\
        ');
        self.remove();
        // self.parents('.box_foods_index').find('.choose-food').removeClass("hidden");
        $('.cart .foods-of-order .food'+res.data.food_id+'').remove();
        $('#total').html(res.data.total);
      }
    }
  });
});

//kiểm tra có thêm gì vào giỏ hàng không

$('body').on('click', '.enter_cart', function(event){
  var self = $(this);
  if(self.parents('.cart').find('.food_of_order').length == 0){
    alertify.error('Chọn thức ăn vào giỏ hàng');
    event.preventDefault();
    return false;
  }else{

  }
});
// $('body .cart').prepend('\
// <div class="col-md-12 alert alert-danger">\
//   <li>Chọn thức ăn vào giỏ hàng</li>\
// </div>\
// ');
// setTimeout(function(){
//   $('body .cart .alert').remove();
// },3000);
// review
  $('.star-rating').raty({
    path: '/assets/',
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });

  $('#star-rating').raty({
    path: '/assets/',
    scorename: 'review[rating]'
  });

// scroll post
var loadding = false;
var nearToBottom = 50;
var page = 2
$(document).scroll(function(){
  console.log("tuan");
  if (loadding) return ;
  if ($(window).scrollTop() + $(window).height() >
      $(document).height() - nearToBottom) {
        loadding = true;
        console.log("khoa");
        $.ajax({
          url: "/api/v1/posts/more_post",
          type: "get",
          data: {
            "page": page
          },
          success: function(res){
              $('.box-posts').append(res.data);
              page += 1 ;
              loadding = false;
          }
        });
  };
});




});
