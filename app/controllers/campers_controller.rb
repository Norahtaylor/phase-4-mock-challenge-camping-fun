class CampersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :camper_record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found

    def index 
        campers = Camper.all
        render json: campers.to_json(only: [:id, :name, :age])
        #render json: campers, only: [:id, :name, :age]
        #why does adding to_json make it work?
    end 

    def show 
        camper = Camper.find(params[:id])
        render json: camper
    end 

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private 

    def camper_params
        params.permit(:name, :age)
    end

    def camper_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def camper_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

end
