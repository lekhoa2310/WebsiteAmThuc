
$(document).ready(function () {
   $("#login_form").validate();

  //  $('form').on('submit', function(e) {
  //    if(!$('[name="cities"]').valid()) {
  //        e.preventDefault();
  //    }
  //   if(!$('[name="user[district_id]"]').valid()) {
  //       e.preventDefault();
  //   }
  //   if(!$('[name="restaurant[district_id]"]').valid()) {
  //       e.preventDefault();
  //   }
  // });


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


});
