class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || theatres_path
  end

  def update_status!(theatre)
    if theatre.include == false
      theatre.update!(status: 'Theatre removed from project')
    elsif theatre.source_org.nil?
      theatre.update!(status: 'Theatre requires onboarding')
    elsif theatre.source_org.deleted == true
      thatre.update!(status: 'Source Org no longer available')
    elsif theatre.performance_spaces.empty?
      theatre.update!(status: 'Performance spaces require defining')
    elsif any_performance_spaces_unmapped?(theatre)
      theatre.update!(status: 'Performance spaces require mapping')
    else
      theatre.update!(status: 'Ready for reporting')
    end
  end

  def any_performance_spaces_unmapped?(theatre)
    mappings = []
    theatre.performance_spaces.each do |space|
      mappings << space.af_venue_mappings.present?
    end
    mappings.include?(false)
  end
end
