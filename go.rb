$:.unshift File.expand_path '../lib/', __FILE__

require 'yearbook'
include Yearbook
PIMGS = Dir.glob "#{File.expand_path '../spec/fixtures/images', '__FILE__'}/*.jpg"

=begin
img = Yearbook::Image.new(PIMGS.first)
img.write('test.jpg') do |i|
  i.bw
  i.resize_to_fit 200, 500
end
=end