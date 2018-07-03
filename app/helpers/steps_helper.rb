module StepsHelper
  def source_content(step)
    if step.source_text.present?
      if step.source_url.present?
        link_to step.source_text, step.source_url, target: '_blank'
      else
        step.source_text
      end
    else
      '-'
    end
  end
end
