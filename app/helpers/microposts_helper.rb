module MicropostsHelper
  def how_long_ago(post_time)
    time = time_ago_in_words(post_time) + "前に投稿"
    if time == "1分未満前に投稿"
      time = "少し前に投稿"
    end
    time
  end
end
