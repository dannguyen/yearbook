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
      fpath = File.expand_path(path)
      @image = Image.new(fpath)

      outpath ||= path.sub(/(?=\.\w*$)/, '-face')
      # eh overwrite it anyway
      @image.clip_and_print_best_face(outpath)
    end
  end


end

