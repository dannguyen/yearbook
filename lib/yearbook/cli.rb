require 'thor'

module Yearbook
  class CLI < Thor
    desc 'hello', 'from'
    def hello(from)
      puts "Hello world, from: #{from}"
    end

    desc 'face', 
    %q{ Provide the path to an image with a face in it:
        yearbook face /path/to/photo.jpg /path/out/face-in-photo.jpg
    }
    def face(path, outpath=nil)
      @image = Yearbook.load_image_from_path(path)
      output_path = Yearbook.determine_output_path(path, outpath)
      
      # eh overwrite it anyway
      @image.clip_and_print_best_face(output_path)
    end

    desc 'faces', 
        %q{ Provide the path to an image with a face in it:
        yearbook face /path/to/photo.jpg /path/out/face-in-photo.jpg
    }

    def faces(path, outpath=nil)
      @image = Yearbook.load_image_from_path(path)
      output_path = Yearbook.determine_output_path(path, outpath)
      
      # eh overwrite it anyway
      @image.clip_and_print_faces(output_path)
    end
  end

  class << self
    def load_image_from_path(path)
      fpath = File.expand_path(path)
      Image.new(fpath)
    end

    def determine_output_path(inpath, outpath=nil)
      output_path = File.expand_path( outpath || inpath )

      if File.directory?(output_path)
        # use path's basename with face
        output_basename = File.basename(inpath).sub(/(?=\.\w*$)/, '-face')
        output_path = File.join(output_path, output_basename)
      end

      puts "Writing to: #{output_path}"
      return output_path
    end
  end
end

