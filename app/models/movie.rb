class Movie < ActiveRecord::Base
    def self.ratings
        Movie.select(:rating).distinct.inject([]) {|arr, mov| arr.push mov.rating}
    end
end