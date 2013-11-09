require 'rmagick'

module Yearbook
  module Manipulator

    class << self
      def bw(img, num_colors = 128)
        img.quantize(num_colors, Magick::GRAYColorspace)
      end


      def constitute(img, *args)
        x,y,w,h = args[0..3]
        pixels = img.dispatch(x, y, w, h, "RGB")

        Magick::Image.constitute(w, h, "RGB", pixels)
      end

      def resize_to_fit(img, w, h = nil)
        h ||= w

        img.resize_to_fit(w, h)
      end


      def load_magick(fname)
        Magick::Image::read(fname).first
      end


    end
  end
end


=begin parameters to use from morgify

adjoin
annotate
append
auto-gamma
auto-level
auto-orient
bench
black-threshold
blend
blue-shift
blur
border
bordercolor
borderwidth
brightness-contrast
charcoal
chop
colorize
colors
colorspace
contrast
convolve
crop
define
depth
deskew
despeckle
display
distort
draw
edge
emboss
enhance
equalize
evaluate
fill
flip
flop
font
format
fuzz
gamma
gaussian-blur
geometry
gravity
level
level-colors
monochrome
motion-blur
negate
noise
normalize
orient
polaroid
posterize
preview
print
process
quality
quantize
quiet
radial-blur
resample
resize
reverse
roll
rotate
scale
selective-blur
sepia-tone
set
shade
shadow
sharpen
shave
shear
size
sketch
solarize
strip
style
swirl
texture
threshold
thumbnail
tint
title
transparent
transparent-color
transpose
transverse
trim
type
unique-colors
units
unsharp
vignette
watermark
weight
white-threshold
=end