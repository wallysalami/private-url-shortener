module ApplicationHelper
  def bootstrap_button (url: nil, layout: 'secondary', label: '', submit: false, icon: nil, tooltip: nil, method: nil, data: [], class_name: '')
    html_options = {}
    
    if url != nil 
      html_options['href'] = url
    end

    html_options['class'] = class_name + ' btn ' + layout.split.map{|x| 'btn-' + x}.join

    if tooltip != nil
      html_options['data-toggle'] = 'tooltip'
      html_options['data-placement'] = 'top'
      html_options['title'] = tooltip
    end

    button_content = ''
    if icon != nil
      size_option = label == '' ? 'fa-lg' : ''
      button_content = content_tag :i, '', class: "fa fa-#{icon} #{size_option}"
    end

    if label != ''
      button_content += content_tag('span', label)
    end

    html_options['method'] = method
    html_options['data'] = data
      
    if submit
      html_options['type'] = 'submit'
    end
      
    if url == nil || submit
      button_tag html_options do
        button_content
      end
    else
      link_to url, html_options do
        button_content
      end
    end
  end
end
