class LeasesController < ApplicationController

    def create 
        lease = Lease.create(lease_params)

        if lease 
            render json: lease
        else
            render json: {error: lease.errors.full_messages}, status_code: :unprocessable_entity
        end
        
    end

    def destroy
        doomed_lease = Lease.find(params[:id])

        if doomed_lease
            doomed_lease.destroy
            head :no_content
        else
            render json: {error: doomed_lease.errors.full_messages}, status_code: :not_found
        end
        
    end

    def lease_params
        params.require(:lease).permit(
            :rent,
            :tenant_id,
            :apartment_id
        )
    end
end
