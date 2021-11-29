class TenantsController < ApplicationController

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def create
        tenant = Tenant.create(tenant_params)

        if tenant.valid?
            render json: tenant, status: :created
        else
            render json: {error: tenant.errors.full_messages}, status_code: :unprocessable_entity
        end
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        if tenant 
            tenant.update(tenant_params)
            render json: tenant
        else
            render json: { error: "Tenant not found" }, status: :not_found
        end
    end

    def destroy
        doomed_tenant = Tenant.find(params[:id])

        if doomed_tenant
            doomed_tenant.destroy
            head :no_content
        else
            render json: {error: doomed_tenant.errors.full_messages}, status_code: :not_found
        end
    end

    def tenant_params
        params.require(:tenant).permit(
            :name,
            :age
        )
    end
end
