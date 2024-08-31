class HotelsController < ApplicationController
    before_action :set_hotel, only: [:show]
  
    # GET /hotels/1
    def show
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def hotel_params
      params.require(:hotel).permit(:name, :description, :hotel_type_id, :total_rooms, :available_rooms, :user_id)
    end
  end
  