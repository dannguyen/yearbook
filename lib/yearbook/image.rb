require 'rmagick'
require 'hashie'



require 'delegate'
class AttHash < SimpleDelegator

  def initialize
    @hsh = {}
    super(@hsh)
  end

  def method_missing(foo, *args, &blk)
    if @hsh.respond_to?(foo)
      @hsh.send(foo, *args, &blk)
    else
     @hsh[foo.to_sym] = args
    end
  end
end



module Yearbook
  class Image

    def initialize(fname)
      @magick_image = read_magick_image(fname)
    end


    def write(out_fname, &blk)
      klass = self.class
      image_out = image_object

      if block_given?
        h = AttHash.new
        yield h

        
        image_out = h.inject(image_out) do |img, (foo, args)|
          klass.send(foo, img, *args)
        end
      end

      klass.output(image_out, out_fname)        
    end


    private
    def read_magick_image(fname)
       Magick::Image::read(fname).first
    end

    def image_object
      @magick_image
    end



    # Image manipulation methods at the class level
    # no reason for them to be instance methods
    class << self 
      def bw(img, num_colors = 128)
        img.quantize(num_colors, Magick::GRAYColorspace)
      end

      def resize_to_fit(img, w, h = nil)
        h ||= w

        img.resize_to_fit(w, h)
      end

      def output(img, out_fname)
        img.write(out_fname)
      end
    end

  end
end