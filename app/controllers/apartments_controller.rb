class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def create
        apartment = Apartment.create(apartment_params)

        if apartment
            render json: apartment, status: :created
        else
            render json: {error: lease.errors.full_messages}, status_code: :unprocessable_entity
        end
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def update
        apartment = Apartment.find(params[:id])
        if apartment 
            apartment.update(apartment_params)
            render json: apartment
        else
            render json: { error: "Apartment not found" }, status: :not_found
        end
    end

    def destroy
        doomed_apartment = Apartment.find(params[:id])

        if doomed_apartment
            doomed_apartment.destroy
            head :no_content
        else
            render json: {error: doomed_apartment.errors.full_messages}, status_code: :not_found
        end
    end

    def apartment_params
        params.permit(
            :number
        )
    end
end
