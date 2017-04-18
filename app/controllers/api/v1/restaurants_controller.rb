module Api::V1
  class RestaurantsController < ApiController

    def find_restaurants_by_city
      if params[:city_id] != 1000
        @districts = District.where city_id: params[:city_id]
        @cities = City.all
        @page = 1
        @restaurants = @districts.first.restaurants.where(actived: true).paginate(:page => params[:page], :per_page => 9)
        @page = params[:page].to_i if params[:page].present?
        html = render_to_string(show: '/api/v1/restaurants/find_restaurants_by_city.html.erb')
        render json: {
          data: html
        }
      else
        @cities = City.all
        @page = 1
        @restaurants = Restaurant.where(actived: true).paginate(:page => params[:page], :per_page => 9)
        @page = params[:page].to_i if params[:page].present?
        html = render_to_string(show: '/restaurants/index.html.erb')
        render json: {
          data: html
        }
      end
    end
  end
end
