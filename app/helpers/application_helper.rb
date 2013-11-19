# -*- encoding : utf-8 -*-
module ApplicationHelper


  def number_to_currency(number, options = {unit: '&euro;', :format => "%n<sup>%u</sup>"})
    options[:precision] = 0 if number == number.floor
    super number, options
  end

  def show_map(resource, options = {auto_zoom: false, disableDefaultUI: false, zoom: 17})
    gmaps(map_options: options, markers: {data: resource.to_gmaps4rails})
  end

  def translate_category(category)
    translate category.permalink, scope: :categories
  end

  def translate_weekday(day)
    if day.is_a? Fixnum
      day = ScheduleItem.ABBREVIATED_WEEKDAYS[day]
    end
    translate day, scope: :abbreviated_weekdays
  end

  def ellipsis(string, options={delimiter: '...', length: 100})
    result = ""
    if string.length > options[:length]
      result << string[0, options[:length]]
      result << options[:delimiter]
    else
      result << string
    end
    result
  end

  def title(string, options = {})
    options = {wrap: true}.merge options
    content_for :title, "#{string} | Jangala Market Beta"
    if options[:wrap]
      content_tag :h1, string, options
    else
      string
    end
  end

  def render_picture(decorated, style=:middle)
    render 'pictures/item', picture: decorated.picture, style: style
  end

  def error_messages_for(errors)

  end

  def pluralize(count, singular, plural = nil)
    res = "#{count || 0} " + "<span class='f-normal'>" + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize)) + "</span>"
    render inline: res
  end

  def is_landing_page?
    (controller_name == 'stores' and action_name.in? %w(new create)) or (controller_name == 'static')
  end

  # Default truncation for product description, news content and deals description
  def default_truncate(text)
    truncate(text, :length => 77)
  end

end
