#!ruby

paths = Dir.glob('*.html')
paths.select! {|path| path != 'blog-index.html' }
paths.sort_by! {|path| File::Stat.new(path).ctime }
paths.reverse!

for path in paths do
  data = File.open(path).read
  creation_time = File::Stat.new(path).ctime
  title = /<title>(.*)<\/title>/.match(data)[1]
  puts "#{creation_time}\t#{path[0, 6]}\t#{title}"
end

