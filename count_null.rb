total = 0
null = 0

File.readlines('old_invalid_postcodes.csv').each do |line|
  total += 1
  split = line.split(',')
  null += 1 if split[2] == "NULL\n"
end

puts "total: #{total}"
puts "null: #{null}"
puts "not null: #{total - null}"