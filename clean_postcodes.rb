# Removes spaces and upcases postcodes
# Note, this is for checking against a list of postcodes in uppercase, with no spaces.
# Postcode values will be saved in lowercase, when the Postcode related custom field is single-option choice.

codes = []
postcodes = []

File.readlines('codes.txt').each do |line|
  codes << line.chomp
end

File.readlines('all_postcodes.csv').each do |line|
  postcodes << line.gsub('"', '').chomp
end

File.open("new_postcodes.csv", "w") { |f|
  postcodes.each do |pc|
    split = pc.split(',')
    check = split[1].gsub(' ', '').upcase
    if codes.include?(check)
      f << "\"#{split[0]}\",\"#{split[1]}\"\n"
    end
  end
}
