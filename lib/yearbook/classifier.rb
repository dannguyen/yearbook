require 'active_support/core_ext/string'

module Yearbook
  class Classifier
    
    DATA_DIR = File.expand_path('../../../data/classifiers', __FILE__ )
    DATA_FILES = {
      faces: File.join(DATA_DIR, 'haarcascade_frontalface_default.xml')
    }

    attr_reader :filename

    def initialize(fname)
      @filename = fname

      @classifier =  load_classifier(@filename)
    end

    def detect_objects(cvimg)
      @classifier.detect_objects(cvimg)
    end




    # convenience
    # will also pluralize anything
    def self.of(object_type)
      object_name = object_type.to_s.pluralize.to_sym

      return self.new DATA_FILES[object_name]
    end


    private
    def load_classifier(fname)
      OpenCV::CvHaarClassifierCascade::load(fname )
    end
  end
end