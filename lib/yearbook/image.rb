require 'rmagick'
require 'hashie'
require_relative 'att_hash'
require_relative 'classifier'




module Yearbook
  class Image

    attr_reader :filename
    def initialize(fname)
      @filename = fname
      @objects = []
    end


    def detect_objects(obj_type)
      @objects = self.class.detect_objects(obj_type)
    end

    def detect_faces
      detect_objects(:faces)
    end


    def detected_objects
      @objects
    end

    def write(base_out_fname, &blk)
      klass = self.class

      if @objects.empty?        
        img_objects = Array(image_object)
      else
        img_objects = @objects.map{|o| constitute_from_cv(o, image_object)}
      end

      img_objects.each_with_index do |image_out, idx|
        if block_given?
          h = AttHash.new
          yield h

          # transform the image
          image_out = h.inject(image_out) do |img, (foo, args)|
            klass.send(foo, img, *args)
          end
        end

        if idx == 0
          out_fname = base_out_fname
        else
          out_fname = base_out_fname.sub(/\.(?=\w+$)/, "-#{idx}.")
        end

        klass.output(image_out, out_fname)
      end        
    end





    private


    # defer loading until it is needed
    def image_object
      @magick_image ||= load_magick_image(@filename)
    end

    def cv_object
      @cv_image ||= load_cv_image(@filename)
    end



    def constitute_from_cv(c, img)
      pixels = img.dispatch(c.x, c.y, c.width, c.height, "RGB")

      return Magick::Image.constitute(c.width, c.height, "RGB", pixels)
    end


    def load_magick_image(fname)
       Magick::Image::read(fname).first
    end


    def load_cv_image(fname)
      IplImage::load(fname)
    end


    # Image manipulation methods at the class level
    # no reason for them to be instance methods
    class << self 
      def bw(img, num_colors = 128)
        img.quantize(num_colors, Magick::GRAYColorspace)
      end

      def detect_objects(img, obj_type)
       Classifier.detect_objects(cv_object, obj_type).to_a
      end

      def detect_faces(img)

      end

      # just gets the main face
      def detect_face(img)

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