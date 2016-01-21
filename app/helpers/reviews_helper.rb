module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = 5 - rating
    '★' * rating.round + ('☆' * remainder)
  end

  def time_created(review)
    time_difference = (Time.now - review.created_at)
    time_ago_to_nearest_hour = (time_difference / (60 * 60)).round
    return "less than an hour ago" if time_ago_to_nearest_hour == 0
    time_ago_to_nearest_hour > 1 ? hour = "hours" : hour = "hour"
    "about #{time_ago_to_nearest_hour} #{hour} ago"
  end
end
