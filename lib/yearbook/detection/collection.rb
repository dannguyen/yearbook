require 'delegate'
require 'pry'

module Yearbook
  module Detection
    class Collection < SimpleDelegator
      def initialize(cvseq, opts={})
        @cv_seq = cvseq

        super(@cv_seq)
      end

      # returns just one of the CvAvgComps
      def best
        arr = sort_by{|c| (c.width * c.height * 0.1) + c.neighbors * 10  }.reverse

        return arr.first
      end
    


    end
  end
end