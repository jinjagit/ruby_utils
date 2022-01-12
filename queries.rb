def filter_spam_users(users)
  users = users.select { |u| u.bio_multiloc.values.any? { |v| v.include?("href=") } }
  users = users.select { |u| u.votes.count == 0 }
  users = users.select { |u| u.ideas.count == 0 }

  puts '======================================'
  puts "Filtered spam users #{DateTime.now} ..."

  users.each do |u|
    puts u.email
  end

  puts '======================================'
end