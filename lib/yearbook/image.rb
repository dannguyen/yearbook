require_relative 'command_mash'
require_relative 'manipulator'
require_relative 'detector'

module Yearbook
  class Image

    attr_reader :filename, :clips
    def initialize(fname)
      @filename = fname      
    end



    # args is empty for now...
    def clip(obj_type, *args, &blk)
      @clips = detect_and_collect(cv_image, obj_type)
    end

    def clipped?; @clips.count > 0; end

    # just the original image
    def print(fname, &blk)
      write_images(magick_image, fname, &blk)
    end

    # print all the clips
    def print_clips(fname, &blk)
      write_images(constitute_clips, fname, &blk)
    end

    def print_best_clip(fname, &blk)
      write_images(constitute_best_clip, fname, &blk)
    end

    # convenience method
    def clip_and_print(obj_type, filename, *args, &blk)
      clip(obj_type, *args, &blk)

      print_clips(filename)
    end

    # convenience method
    def clip_and_print_best(obj_type, filename, *args, &blk)
      clip(obj_type, *args, &blk)

      print_best_clip(filename)
    end


    ### META STUFF

    CLIPPER_REGEX = /^(clip_and_print(?:_best)?|clip)_(\w+)$/
    def method_missing(foo, *args, &blk)
      f = foo.to_s
      # e.g. clip_faces
      if f =~ CLIPPER_REGEX
        self.send $1, $2, *args, &blk
      else
        super
      end
    end

    def respond_to?(foo, include_private=false)
      return foo.to_s =~ CLIPPER_REGEX ? true : super(foo, include_private)
    end




    private

    def best_clip
      @clips.best
    end

    def constitute_from_cv(cv, img)
      Manipulator.constitute(img, cv.x, cv.y, cv.width, cv.height)
    end

    def constitute(objects)
      objs = Array(objects)
      objs.map{|o| constitute_from_cv(o, magick_image)}
    end

    # just a helper
    def constitute_clips
      constitute(@clips)
    end

    def constitute_best_clip
      constitute(best_clip)
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
        method_queue = CommandMash.new
        yield method_queue

        # transform the image
        transformed_obj = method_queue.inject(transformed_obj) do |img, (foo, args)|
          Manipulator.send(foo, img, *args)
        end
      end

      return transformed_obj
    end

    def write_images(magick_objects, base_out_fname, &blk)    

      arr = Array(magick_objects)

      arr.each_with_index do |obj, idx|
        output_img = transform_image(obj, &blk)
        # generate a numbered filename if there are more than one
        output_fname = arr.count == 1 ? base_out_fname : base_out_fname.sub(/\.(?=\w+$)/, "-#{idx}.")

        write_image(output_img, output_fname)
      end
    end


    # img is expected to be a Magick Object
    def write_image(img, out_fname)
      img.write(out_fname)
    end

  end
end