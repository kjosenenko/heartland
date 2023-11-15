require 'date'

input = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

output = "Krakow02.jpg
London1.png
Krakow01.png
Florianopolis2.jpg
Florianopolis1.jpg
London2.jpg
Florianopolis3.png
Krakow03.jpg
Krakow09.png
Krakow07.jpg
Krakow06.jpg
Krakow08.jpg
Krakow04.png
Krakow05.png
Krakow10.jpg"

def solution(s)
  # Split at each line break.
  s = s.split(/\n/)
  # Iterate through each array item and replace the string item with an array item.
  s.each_with_index do |item, index| 
    s[index] = item.split(', ')
  end
  # Create a hash where keys are city names and values are arrays of photos from that city.
  hash = {}
  s.each do |item|
    # Unless hash key exists for city, create a key with an empty array as value.
    hash[item[1]] = [] unless hash[item[1]]
    # Create a date object for the date string
    date = item[2].split(/-|:| /)
    date = DateTime.new(date[0].to_i,date[1].to_i,date[2].to_i,date[3].to_i,date[4].to_i,date[5].to_i)
    # Inject the array for the photo item into the array for the city key.
    hash[item[1]] << {name: item[0], date: date}
  end
  hash.each do |city, photos|
    # Order value by date.
    hash[city] = photos.sort_by{|photo| photo[:date]}
    # Once the value is ordered by date all that is needed is the name.
    hash[city] =  hash[city].collect{|photo|photo[:name]}
  end
  results = []
  s.each do |item|
    # Get the index of the item in the ordered hash value, add one to offset 0 and convert to string.
    item_index = (hash[item[1]].find_index(item[0])+1).to_s
    # If there are more than 9 items in the array add a leading 0 if the item index is a single digit.
    item_index = '0' + item_index if hash[item[1]].length > 9 && item_index.to_i < 10
    # Get the file extension name
    ext_name = File.extname(item[0])
    # Inject the renamed photo into the results array
    results << (item[1] + item_index + ext_name)
  end
  # Return the results array as a string joined by a line break.
  results.join("\n")
end

if solution(input) == output
  puts 'Input argument passed into the solution method produces output.'
else
  puts 'Input argument passed into the solution method does not produce output.'
end
