class TheatresController < ApplicationController
  before_action :set_theatre, only: [:show, :edit, :update, :destroy]
  before_action :all_source_orgs, only: [:new, :edit]
  before_action :used_source_orgs, only: [:new, :edit]

  def index
    @theatres = Theatre.all.order(:name)
  end

  def show
    add_breadcrumb '< All Theatres', theatres_path
    @performance_spaces = @theatre.performance_spaces
    @af_venues = @theatre.af_venues
  end

  def new
    @theatre = Theatre.new
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      redirect_to theatres_path
    else
      render :new
    end
  end

  def edit
    @used_src_org_ids.delete(@theatre.source_org_id)
  end

  def update
    if @theatre.update!(theatre_params)
      redirect_to theatre_path(@theatre)
    else
      render :edit
    end
  end

  private

  def all_source_orgs
    @source_orgs = SourceOrg.all.order('name ASC')
  end

  def used_source_orgs
    @theatres = Theatre.all
    @used_src_org_ids = Array(@theatres.map { |theatre| theatre.source_org_id })
  end

  def set_theatre
    @theatre = Theatre.find(params[:id])
  end

  def theatre_params
    params.require(:theatre).permit(:name, :management, :source_org_id, :notes, :include)
  end
end
