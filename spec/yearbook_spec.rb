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

      describe '#write' do
        it 'should write to disk' do 
          @image.write(@tempfile.path)
          expect(@tempfile.size > 10000).to be_true
        end

        context 'after faces have been detected' do 
          before do 
            @image.detect_faces
          end

          it 'should write each object to disk' do 
            last_num = @image.detected_objects.count - 1
            path = @tempfile.path
            last_path = path.sub(/\.(?=\w+$)/, "-#{last_num}.")

            @image.write(path)
            expect(File.exists?(last_path)).to be_true
          end

        end
      end



    end


  end
end