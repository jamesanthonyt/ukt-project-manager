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
    status_class = ''

    case theatre.status
    when 'Theatre removed from project'
      status_class = "'text-danger font-weight-bold'"
    when 'Theatre requires onboarding', 'Source Org no longer available'
      status_class = 'text-danger'
    when 'Performance spaces require defining', 'Performance spaces require mapping'
      status_class = 'text-warning'
    when 'Ready for reporting'
      status_class = 'text-success'
    else
      status_class = 'text-secondary'
    end

    "<span class=#{status_class}>#{theatre.status}</span>".html_safe
  end
end
