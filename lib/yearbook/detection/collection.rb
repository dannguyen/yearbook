require 'delegate'

module Yearbook
  module Detection
    class Collection < SimpleDelegator
      def initialize(cvseq, opts={})
        @cv_seq = cvseq

        super(@cv_seq)
      end

      # returns just one of the CvAvgComps
      def best
        sort_by{|c| c.width * c.height}.reverse.first
      end
    

    end
  end
end