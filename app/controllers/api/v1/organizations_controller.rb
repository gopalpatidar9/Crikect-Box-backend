class Api::V1::OrganizationsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @organizations =  Organization.all
    render json: @organizations
  end

  def create
    @organization =  Organization.create(name: params[:name])
    respond_to do |format|
      if @organization.save
        organization_name = params[:name]
        organization_name = organization_name.gsub(" ", "_")
        Apartment::Tenant.create(name: organization_name)
        format.json{ render :show , status: :created}
      else
        format.json{ render @organization.errors , status: :feild }
      end
    end  
  end

  def show
    @organization = Organization.find_by(id: params[:id])
    if @organization
      render json: @organization
    else 
      render json:{error: 'not found'} , status: :not_found
    end
  end 

  def destroy
    @organization = Organization.find_by(id: params[:id])
    if @organization
      @organization.destroy
      render json: @organizations
    else  
      render json:{error: 'not deleted'} , status: :not_destroy
    end
  end

  private

  def organization_params
    params.require(:organization).parmit(:name)
  end
end
