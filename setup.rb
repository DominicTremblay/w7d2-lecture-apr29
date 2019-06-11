require 'active_record'
require 'pg'
require 'faker'
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
  create_table :artists, force: true do |t|
    t.string :name, null: false
    t.timestamps
  end

  create_table :albums, force: true do |t|
    t.string :title
    t.integer :year
    t.references :artist, foreign: true
    t.timestamps
  end

  create_table :tracks, force: true do |t|
    t.string :title
    t.integer :number
    t.references :album, foreign: true
    t.timestamps
  end

  create_table :tags, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :artist_tags, force: true do |t|
    t.references :artist, foreign: true
    t.references :tag, foreign: true
    t.timestamps
  end
end

  puts "Adding Artists ----------------"
  20.times do
    Artist.create!(name: Faker::Music.band)
  end

  puts "Adding Albums ---------------"
  Artist.all.each do |artist|
    3.times do
      artist.albums.create(title: Faker::Music.album, year: rand(1995..2019))
    end
  end

  puts "Adding Tracks ------------"

  Album.all.each do |album|
    5.times do |nb|
      album.tracks.create!(title: Faker::Music::Phish.song, number: nb + 1)
    end
  end

  puts "Adding tags -------------"

  20.times do
    Tag.create!(name: Faker::Music.genre)
  end

  puts "Adding artist tags ----------------"

  30.times do
    ArtistTag.create!(artist: Artist.all.sample, tag: Tag.all.sample)
  end
  

  binding.pry

  puts