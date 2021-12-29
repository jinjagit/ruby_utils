# Wraps lines in text file in quotes.
# Useful for preparing columns of data from excel, that contain commas in the cells,
# before using in CSV.
# See also 'combine_cols.rb' for re-combining such 'columns' into CSV-like format.

lines = []

File.readlines('col2_raw.txt').each do |line|
  lines << line.chomp
end

File.open("col2.txt", "w") { |f|
  lines.each do |line|
    f << "\"#{line}\"\n"
  end
}