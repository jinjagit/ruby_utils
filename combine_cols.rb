# Combines n columns of data, given as text files, into one text file.
# Separates the column data with commas, CSV style.

# Text files must contain same number of rows of data (will be checked);
# Remove extra empty line(s) from end of text files as needed.
# Typically last line is empty (and does not contain a \n, so is not really a line.)

files = ['col1.txt', 'col2.txt'] # Edit to taste.
counts = []

files.each do |filename|
  n = 0
  File.open(filename) {|f| n = f.read.count("\n")}
  counts << n
end

if counts.uniq.size != 1
  raise "Error! File line counts are not equal."
end

data = []

files.each do |filename|
  lines = []

  File.readlines(filename).each do |line|
    lines << line.chomp
  end

  data << lines
end

newlines = []

counts[0].times do |i|
  newline = ''

  data.length.times do |j|
    newline = newline + data[j][i] + ','
  end

  newline = newline.chomp(',')
  newlines << newline
end

File.open("output.txt", "w") { |f| # Edit to taste.
  newlines.each do |newline|
    f << newline + "\n"
  end
}