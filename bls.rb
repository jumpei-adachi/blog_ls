#!ruby

paths = Dir.glob('*.html')
  .select {|path| path != 'blog-index.html' }
  .sort_by {|path| File::Stat.new(path).ctime }
  .reverse

paths.each do |path|
  short_file_name = path[0, 6]

  creation_time = File::Stat.new(path).ctime

  title = /<title>(.*)<\/title>/
    .match(File.read(path))[1]

  puts [
    creation_time,
    short_file_name,
    title
  ].join("\t")
end

