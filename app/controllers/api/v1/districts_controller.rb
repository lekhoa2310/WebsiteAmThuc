module Api::V1
  class DistrictsController < ApiController

    def return_districts_by_city_id

      @districts = District.where city_id: params[:city_id]
      html = render_to_string(show: 'api/v1/districts/return_districts_by_city_id.html.erb', layout: false)
      render json: {
        data: html
      }
    end

  end
end
