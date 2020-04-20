module TheatresHelper
  def group_name(grouping)
    case grouping
    when '1'
      'Major principally presenting performance space'
    when '2'
      'Large principally presenting performance space'
    when '3'
      'Medium principally presenting performance space'
    when '4'
      'Principally producing performance space'
    when '5'
      'Smaller performance space'
    when '6'
      'Miscellaneous performance space'
    end
  end

  def status(theatre)
    if theatre.include == false
      '<span style="color: red; font-weight: bold;">Theatre removed from project</span>'.html_safe
    elsif theatre.source_org.nil?
      '<span style="color: red">Theatre requires onboarding</span>'.html_safe
    elsif theatre.source_org.deleted == true
      '<span style="color: red">Source Org no longer available</span>'.html_safe
    elsif theatre.performance_spaces.empty?
      '<span style="color: orange">Performance spaces require defining</span>'.html_safe
    elsif any_performance_spaces_unmapped?(theatre)
      '<span style="color: orange">Performance spaces require mapping</span>'.html_safe
    else
      '<span style="color: green">Ready for reporting</span>'.html_safe
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
