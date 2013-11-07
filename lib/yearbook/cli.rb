require 'thor'

module Yearbook
  class CLI < Thor
    desc 'hello', 'from'
    def hello(from)
      puts "Hello world, from: #{from}"
    end

    desc 'face', 'provide the path to an image with a face in it'
    def face(path, outpath=nil)
      fpath = File.expand_path(path)
      @image = Image.new(fpath)

      outpath ||= path.sub(/(?=\.\w*$)/, '-face')
      # eh overwrite it anyway
      @image.write(outpath)
    end

  end
end

