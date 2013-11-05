$:.unshift File.expand_path '../lib/', __FILE__

require 'yearbook'
include Yearbook
PIMGS = Dir.glob "#{File.expand_path '../spec/fixtures/images', '__FILE__'}/*.jpg"

img = Yearbook::Image.new(PIMGS.first)
img.write('test.jpg') do |i|
  i.bw
end