class ArtistTag < ActiveRecord::Base

  belongs_to :artist
  belongs_to :tag
end