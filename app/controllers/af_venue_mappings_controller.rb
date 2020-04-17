class AfVenueMappingsController < ApplicationController
  before_action :set_af_venue_mapping
  def new
    @mapping = AfVenueMapping.new
    @theatre_performance_spaces = PerformanceSpace.where(theatre_id: @theatre.id)
  end

  def create
    @mapping = AfVenueMapping.new
    @mapping.af_venue_id = @af_venue.id
    @mapping.source_org_id = @af_venue.source_org_id
    @mapping.update(af_mapping_params)
    if @mapping.save
      redirect_to theatre_path(@theatre)
    else
      render :new
    end
  end

  def destroy
    @mapping = AfVenueMapping.find(params[:id])
    @mapping.destroy
    redirect_to theatre_path(@theatre)
  end

  private

  def af_mapping_params
    params.require(:af_venue_mapping).permit(
      :performance_space_id
    )
  end

  def set_af_venue_mapping
    @theatre = Theatre.find(params[:theatre_id])
    @af_venue = AfVenue.find(params[:af_venue_id])
  end
end
