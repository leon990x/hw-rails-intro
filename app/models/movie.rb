class Movie < ActiveRecord::Base
    def self.ratings_all
        Movie.select(:rating).distinct.inject([]) { |a, m| a.push m.rating }
    end
end