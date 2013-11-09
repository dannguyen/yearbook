require_relative 'att_hash'
require_relative 'manipulator'
require_relative 'detector'

module Yearbook
  class Image

    attr_reader :filename
    def initialize(fname)
      @filename = fname
      @objects = []
    end


    # args is empty for now...
    def detect_objects(obj_type, *args)
      @objects = detect_and_collect(cv_image, obj_type)
    end

    def detected_objects; @objects; end


    def print(fname, &blk)
      write_objects(fname, &blk)
    end



    def method_missing(foo, *args, &blk)
      f = foo.to_s
      # e.g. detect faces
      if f =~ /^detect_(\w+)/
        self.detect_objects(($1).to_sym, &blk)
      else
        super
      end
    end

    def respond_to?(foo, include_private=false)
      return foo.to_s =~ /^detect_(\w+)/ ? true : super(foo, include_private)
    end




    private

    def constitute_from_cv(c, img)
      Manipulator.constitute(img, c.x, c.y, c.width, c.height)
    end

    def cv_image
      @_cv_image ||= Detector.load_cv(@filename)
    end

    def detect_and_collect(cv, obj_type)
      Detector.detect_objects(cv, obj_type)
    end
   
    # defer loading until it is needed
    def magick_image
      @_magick_image ||= Manipulator.load_magick(@filename)
    end


    # returns a manipulated Magick file
    def transform_image(obj, &blk)
      transformed_obj = obj
      if block_given?
        method_queue = AttHash.new
        yield method_queue

        # transform the image
        transformed_obj = method_queue.inject(transformed_obj) do |img, (foo, args)|
          Manipulator.send(foo, img, *args)
        end
      end

      return transformed_obj
    end

    def write_objects(base_out_fname, &blk)
      if @objects.empty?        
        # i.e. just writing from a regular ol magick file
        magick_objects = Array(magick_image)
      else
        # converting CvRect coordinates and splitting the Magick file
        magick_objects = @objects.map{|o| constitute_from_cv(o, magick_image)}
      end

      magick_objects.each_with_index do |obj, idx|
        # generate a numbered filename if there are more than one
        output_img = transform_image(obj, &blk)
        output_fname = idx == 0 ? base_out_fname : base_out_fname.sub(/\.(?=\w+$)/, "-#{idx}.")

        write_image(output_img, output_fname)
      end
    end


    # img is expected to be a Magick Object
    def write_image(img, out_fname)
      img.write(out_fname)
    end



  end
end