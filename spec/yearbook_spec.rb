require 'spec_helper'

module Yearbook
  describe Image do

    context 'instance' do 
      before do 
        @fname = File.join(IMAGE_DIR, 'bush-george-w.jpg')
        @image = Image.new(@fname)
        @tempfile = Tempfile.new 'bush.jpg'
      end

      after do 
        @tempfile.unlink
      end


      describe 'initialization' do 
        it 'should have :filename reader' do 
          expect(@image.filename).to eq @fname
        end
      end

      describe '#detect_faces' do
        it 'should return an Array' do 
          expect( @image.detect_faces ).to be_an Array
        end
      end

      describe '#print' do
        it 'should write to disk' do 
          @image.print(@tempfile.path)
          expect(@tempfile.size > 10000).to be_true
        end

        context 'after faces have been detected' do 
          before do 
            @image.detect_faces
          end

          it 'should print each object to disk' do 
            last_num = @image.detected_objects.count - 1
            path = @tempfile.path
            last_path = path.sub(/\.(?=\w+$)/, "-#{last_num}.")

            @image.print(path)
            expect(File.exists?(last_path)).to be_true
          end

        end
      end


      context 'croppping to detection' do 
        it 'should allow close cropping'
        it 'should take in percentages and weights'

        # crop_to_object -10, -20

      end


      context 'detection' do
        before(:each) do
          @image.detect_faces
        end

        it 'should' do 
          pending 'what'
          @image.detected? # to eq true
          @image.detected_objects # to be an array
          @image.detected_objects # to eq CV thingy

#           # API:
#           img = @image.new(@fname) 
#           img.detect_face 
#           img.write do |f|
# # etc          do |f|
#             f.detect_face  # -d face
#             f.bw  # --bw
#             f.resize_to_fill(100, 200)  # --fill 100,200
#             f.write(whatev)
#           end

# yearbook photo.jpg face.jpg --detect face 

        end
      end

    end
  end
end