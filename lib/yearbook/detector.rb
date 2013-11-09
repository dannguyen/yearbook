require_relative 'classifier'

module Yearbook
  module Detector

    class << self 
      # returns an array of detected objects
      def detect_objects(cv_image, object_type)
        x = Classifier.of(object_type).detect_objects(cv_image)

        return Array(x)
      end


      def load_cv(fname)
        IplImage::load(fname)
      end
      

    end
  end
end