
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
     var sefl = $(this);
     $.ajax({
       url: $(this).attr("data-target"),
       type: "post",
       success: function(res){
         console.log(res);
         sefl.parents('.post-item').find('.view-like').html(res.data.likes);
         if(res.data.isLike == false)
          sefl.html("Thích");
         else
          sefl.html("Không thích");
       }
     });
   });



});
