if RUBY_VERSION < '1.9.2'
  STDERR.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  STDERR.puts "This app requires ruby 1.9.2 or higher!"
  STDERR.puts "Google for RVM in case you don't have Ruby 1.9.2 installed." 
  STDERR.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  exit(-1)
end