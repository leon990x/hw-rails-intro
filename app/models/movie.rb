class Movie < ActiveRecord::Base
    def self.all_ratings
        #self.all.select(:rating).distinct.pluck(:rating)
        Movie.select(:rating).distinct.inject([]) { |a, m| a.push m.rating }
    end
end