require 'spec_helper'

module Yearbook
  describe 'DetectedObject' do 

    describe 'initialization' do 
      it 'should accept a single CvRect like object'
      it 'should accept four coordinates'
    end

    describe 'acts like a CvRect' do 
      it 'has :x'
      it 'has :y'
      it 'has :width'
      it 'has :height'
      it 'has :pixel_count'
      it 'has :center'

    end

    describe '#likeliness' do 
      it 'by default, is based off of pixel_count'
    end

  end
end