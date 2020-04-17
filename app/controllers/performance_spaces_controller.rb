class PerformanceSpacesController < ApplicationController
  before_action :set_theatre, only: [:new, :create]
  before_action :set_performance_space, only: [:show, :edit, :update]

  def show
    add_breadcrumb "< #{@theatre.name}", theatre_path(@theatre)
    @af_venues = AfVenue.joins(:af_venue_mapping)
                        .where(af_venue_mappings: { performance_space_id:
                          @performance_space })
  end

  def new
    @performance_space = PerformanceSpace.new
  end

  def create
    @performance_space = PerformanceSpace.new(performance_space_params)
    @performance_space.theatre_id = @theatre.id
    assign_group(@performance_space)
    if @performance_space.save
      redirect_to theatre_path(@theatre)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @performance_space.update(performance_space_params)
      assign_group(@performance_space)
      @performance_space.save
      redirect_to theatre_path(@theatre)
    else
      render :edit
    end
  end

  private

  def set_theatre
    @theatre = Theatre.find(params[:theatre_id])
  end

  def set_performance_space
    set_theatre
    @performance_space = PerformanceSpace.find(params[:id])
  end

  def performance_space_params
    params.require(:performance_space).permit(
      :name,
      :space_type,
      :capacity,
      :programme,
      :grouping,
      :notes
    )
  end

  # This needs to be refactored
  def assign_group(performance_space)
    if performance_space.space_type == 'Other' || performance_space.space_type == 'Cinema' || performance_space.space_type == 'Cabaret Space'
      performance_space.grouping = 6
    elsif performance_space.capacity < 200
      performance_space.grouping = 5
    elsif (performance_space.programme.include? 'produced') && performance_space.capacity >= 200
      performance_space.grouping = 4
    elsif (performance_space.programme.include? 'presented') && performance_space.capacity.between?(200, 599)
      performance_space.grouping = 3
    elsif (performance_space.programme.include? 'presented') && performance_space.capacity.between?(600, 999)
      performance_space.grouping = 2
    elsif (performance_space.programme.include? 'presented') && performance_space.capacity >= 1000
      performance_space.grouping = 1
    end
  end
end
