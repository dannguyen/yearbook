require 'spec_helper'
module Yearbook
  module Detection
    describe Collection do

      describe 'initialization' do
        it 'should accept an array of objects' do 

        end
      end


      describe 'act like an array' do 
        it 'should be an Enumerable'
        it 'should have a count'
      end

      describe 'special sorting' do
        describe '#sort_by_position' do 
          it 'should sort by left-to-right, up-to-down'
        end

        describe '#sort_by_likeliness' do 
          it 'should sort by "likeliness"'
        end
      end

    end
  end
end
