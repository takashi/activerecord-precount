require 'cases/helper'

class BugReportTest < ActiveRecord::CountLoader::TestCase
  def setup
    tweets_count.times do |i|
      tweet = Tweet.create
      i.times do |j|
        Favorite.create(tweet: tweet, user_id: j + 1)
      end
    end
  end

  def teardown
    [Tweet, Favorite].each(&:delete_all)
  end

  def tweets_count
    3
  end

  def test_save_break_with_count_loader_and_dependent_destroy
    tweet = Tweet.first
    tweet.my_favorites_count
    tweet.save!
  end
end
