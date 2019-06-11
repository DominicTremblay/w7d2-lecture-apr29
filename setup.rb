require 'pg'
require 'faker'
require 'active_record'
require 'pry'


require_relative './models/artist'
require_relative './models/album'
require_relative './models/track'
require_relative './models/tag'
require_relative './models/artist_tag'

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  user: 'labber',
  password: 'labber',
  database: 'w7d2_lecture'
)

ActiveRecord::Schema.define do

puts "Creating table artists ------------"
create_table :artists, force: true do |t|
  t.string :name, null: false
  t.timestamps
end

puts "Creating the Albums table ---------"
create_table :albums, force: true do |t|
  t.string :title, null: false
  t.integer :year, null: false
  t.references :artist, foreign: true
  t.timestamps
end

puts 'Creating the Tracks table --------'
create_table :tracks, force: true do |t|
  t.string :title
  t.integer :number
  t.references :album, foreign: true
  t.timestamps
end

puts 'Creating the tags table ---------'
create_table :tags, force: true do |t|
  t.string :name
  t.timestamps
end

puts 'Creating artist_tags ----------'
create_table :artist_tags, force: true do |t|
  t.references :artist, foreign: true
  t.references :tag, foreign: true
end




end

20.times do
  Artist.create(name: Faker::Name.name)
end

Artist.all.each do |artist|

  3.times do 
    artist.albums.create(title: Faker::Music.band, year: rand(1990..2019))
  end

end

Album.all.each do |album|

  12.times do |n|
    album.tracks.create(title: Faker::Music::Phish.song, number: n + 1)
  end

50.times do 
  Tag.create(name: Faker::Music.genre)
end

30.times do
  ArtistTag.create(artist_id: Artist.all.sample.id, tag_id: Tag.all.sample.id )
end


end

binding.pry
puts