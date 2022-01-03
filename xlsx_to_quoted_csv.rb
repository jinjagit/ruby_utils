# Solution to problem of converting excel files with cell values that include commas to csv files.
# Wraps content of each excel cell in quotes.
# Includes some code for multiple worksheets, but currently only deals with first worksheet.

# Usage: ruby xlsx_to_quoted_csv.rb <input_xlsx_file> <output_csv_ile> <optional: any value = do not insert empty quotes for empty cell>

# Preparation: Remove unused columns and rows from the input xlsx file.

require 'rubyXL'

class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

input = ARGV.shift
output = ARGV.shift
clean = ARGV.shift || nil

raise "missing argument" unless input and output

rows = []

# ============   Read   ===============

workbook = RubyXL::Parser.parse input

worksheets = workbook.worksheets
puts "Found #{worksheets.count} worksheets"

worksheets.each do |worksheet|
  puts "Reading: #{worksheet.sheet_name}"
  num_rows = 0

  worksheet.each do |row|
    rows << row.cells.map{ |cell| cell.value }
    num_rows += 1
  end
  puts "Read #{num_rows} rows".green
end

# ===========   Write   ===============

puts "Writing: #{output}"
num_rows = 0

File.open(output, "w") { |f| # Edit to taste.
  rows.each do |row|
    line = ''
    row.each_with_index do |cell, i|
      line = line + '"' + cell.to_s + '"' unless (cell.nil? or cell.empty?) && clean

      if i + 1 != row.length
        line = line + ','
      end
    end

    f << line + "\n"
    num_rows += 1
  end
}

puts "Wrote #{num_rows} rows".green
