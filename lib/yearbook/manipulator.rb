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