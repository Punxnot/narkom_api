class SearchController < ApplicationController
  require 'wikipedia'

  Wikipedia.configure {
    domain 'ru.wikipedia.org'
    path   'w/api.php'
  }

  def items
    page = Wikipedia.find(params[:query])
    render json: {text: page.summary, image: page.main_image_url}
  end

  def age
    todays_date = DateTime.now.to_date
    birth_date = params[:query].to_date
    difference_in_days = (birth_date..todays_date).to_a.size
    difference_in_hours = difference_in_days * 24
    difference_in_minutes = difference_in_hours * 60
    difference_in_seconds = difference_in_minutes * 60
    @age = Age.find_by days: difference_in_days
    milestone = get_milestone(birth_date)
    age_numbers = {
      days: difference_in_days,
      hours: difference_in_hours,
      minutes: difference_in_minutes,
      seconds:difference_in_seconds
    }

    if @age
      wiki_data = Wikipedia.find(@age.events[0].title)
      render json: {age_description: @age.description,
                    events: @age.events,
                    age_numbers: age_numbers,
                    wiki: {
                      text: wiki_data.summary,
                      image: wiki_data.main_image_url
                    }
      }
    elsif milestone
      text = "Time to celebrate! You are #{milestone} today!"
      render json: {age_description: text, age_numbers: age_numbers}
    else
      render json: {age_numbers: age_numbers}
    end
  end

  private

  def get_milestone(date)
    todays_date = DateTime.now.to_date
    difference_in_days = (date..todays_date).to_a.size
    difference_in_hours = difference_in_days * 24
    difference_in_minutes = difference_in_hours * 60

    milestone = nil

    if difference_in_days % 1000 === 0 or is_palindrome(difference_in_days) or is_same_figures(difference_in_days) or is_binary_round(difference_in_days)
      milestone = "#{difference_in_days} days"
    elsif difference_in_hours % 10000 === 0 or is_palindrome(difference_in_hours) or is_same_figures(difference_in_hours) or is_binary_round(difference_in_hours)
      milestone = "#{difference_in_hours} hours"
    elsif difference_in_minutes % 1000000 === 0 or is_palindrome(difference_in_minutes) or is_same_figures(difference_in_minutes) or is_binary_round(difference_in_minutes)
      milestone = "#{difference_in_minutes} minutes"
    end
  end

  def is_palindrome(num)
    num = num.to_s
    num == num.reverse
  end

  def is_same_figures(num)
    num = num.to_s

    num[1..num.length].split("").each do |i|
      if i != num[0]
        return false
      end
    end

    return true
  end

  def is_binary_round(num)
    num = num.to_s(2)

    is_same_figures(num)
  end
end
