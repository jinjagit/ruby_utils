items = []

File.readlines('test.txt').each do |line|
  parts = line.split(';')
  parts.each do |part|
    items << part.strip
  end
end

unique = items.uniq

unique.each do |item|
  puts item
end
