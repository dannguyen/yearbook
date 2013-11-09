require_relative 'detection/collection'

module Yearbook
  module Detection; end

  class << self
    def DetectionCollection(cvseq, obj_type = nil)
      Detection::Collection.new(cvseq)
    end
  end
end

