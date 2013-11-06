module Yearbook
  module Classifier
    
    DATA_DIR = File.expand_path('../../../data/classifiers', __FILE__ )
    DATA_FILES = {
      faces: File.join(DATA_DIR, 'haarcascade_frontalface_default.xml')

    }


    # returns an array of detected objects
    def self.detect_objects(cv_image, object_type)
      detector = load_detector(object_type.to_sym)

      detector.detect_objects(cv_image)
    end


    def self.load_detector(object_type)
      fname = DATA_FILES[object_type]
      puts fname
      OpenCV::CvHaarClassifierCascade::load( fname )
    end

  end
end