require 'exifr/jpeg'
require 'geocoder'

puts 'Starting '
puts 'Width: ', EXIFR::JPEG.new('DSCN0010.jpg').width               # => 2272
puts 'Height: ', EXIFR::JPEG.new('DSCN0010.jpg').height              # => 1704
puts 'exit?: ', EXIFR::JPEG.new('DSCN0010.jpg').exif?               # => true
puts 'Model: ', EXIFR::JPEG.new('DSCN0010.jpg').model               # => "Canon PowerShot G3"
puts 'Date-Time: ', EXIFR::JPEG.new('DSCN0010.jpg').date_time           # => Fri Feb 09 16:48:54 +0100 2007
puts 'Exposure Time: ', EXIFR::JPEG.new('DSCN0010.jpg').exposure_time.to_s  # => "1/15"
puts 'F Number: ', EXIFR::JPEG.new('DSCN0010.jpg').f_number.to_f       # => 2.0
puts 'Latitude: ', latitude=EXIFR::JPEG.new('DSCN0010.jpg').gps.latitude       # => 52.7197888888889
puts 'Longitude: ', longitude=EXIFR::JPEG.new('DSCN0010.jpg').gps.longitude      # => 5.28397777777778
puts 'Finished'

require 'net/http'
require 'uri'
require 'json'

api_key = ENV[GOOGLE_MAPS_API_KEY]

# Construct the API URL (example using Google Maps)
url = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&key=#{api_key}")

response = Net::HTTP.get_response(url)
data = JSON.parse(response.body)

# Extract location information
if data["status"] == "OK"
  address = data["results"][0]["formatted_address"]
  puts address
else
  puts "Geocoding failed: #{data["status"]}"
end
