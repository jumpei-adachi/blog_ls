#!ruby

# 作成日時の降順でhtmlファイルのリストを作成
paths = Dir.glob('*.html')
  .select {|path| path != 'blog-index.html' }
  .sort_by {|path| File::Stat.new(path).birthtime }
  .reverse

paths.each do |path|
  short_file_name = path[0, 6]

  creation_time = File::Stat.new(path).birthtime

  # title要素のテキスト内容を正規表現を用いて取得
  title = /<title>(.*)<\/title>/
    .match(File.read(path))[1]

  puts [
    creation_time,
    short_file_name,
    title
  ].join("\t")
end

