require 'spec_helper'

module Yearbook
  module Manipulator

    describe '.bw' do
      it 'creates a grayscale image'
      describe 'optional parameters' do 
        it 'first parameter describes ranges'
      end
    end


    describe '.resize' do
      describe 'required parameters' do 
        it 'accepts WIDTHxHEIGHT as a String'
        it 'accepts :w and scales :height accordingly'
        it 'accepts :w=nil/0 and :h > 0 and scales :width accordingly'
      end
    end



  end
end    