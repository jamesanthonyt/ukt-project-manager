module PerformanceSpacesHelper
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
end
