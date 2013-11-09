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

      context 'clipping' do
        before(:each) do
          @image.clip_faces
        end

        it 'should be #clipped?' do 
          expect(@image).to be_clipped
        end

        describe '@clips' do
          it 'should return an Detection::Collection' do 
            expect( @image.clips ).to be_a Yearbook::Detection::Collection
          end
        end
      end

      describe 'printing' do 
        describe '#print' do
          it 'should write the same file to disk' do 
            @image.print(@tempfile.path)
            expect(@tempfile.size > 10000).to be_true
          end
        end

        describe '#print_clips' do 
          context 'after faces have been clipped' do 
            before do 
              @image.clip_faces
            end

            it 'should print each object to disk' do 
              temp_path = @tempfile.path
              @image.print_clips(temp_path)
              @image.clips.each_with_index do |idx|
                clip_path = temp_path.sub(/\.(?=\w+$)/, "-#{idx}.")
                expect(File.exists?(clip_path)).to be_true
              end                          
            end
          end
        end

        describe '#print_best_clip' do
          before do 
            @image.clip_faces
            @image.print_best_clip(@tempfile.path)
          end

          it 'should print the one face' do 
            expect(File.exists?@tempfile.path).to be_true
          end

          it 'that face should be the biggest face' do 
            best_face = @image.send(:best_clip)

            # icky method, requires using best_clip private method
            # AND knowing default Detection::Collection :best sorting

            pixel_count = best_face.width * best_face.height
            magick_image = Manipulator.load_magick(@tempfile.path)

            expect(pixel_count).to eq magick_image.columns * magick_image.rows
          end
        end

        context 'meta-conveniences' do 
          it 'should have #clip_and_print_faces' do 
            pending 'better path'
            @image.clip_and_print_faces(@tempfile.path)
          end

          it 'should have #clip_and_print_best_face' do 
            # note how tolerant it is of singular things
            @image.clip_and_print_best_face(@tempfile.path)
            best_face = @image.send(:best_clip)

            # redux test
            # icky method, requires using best_clip private method
            # AND knowing default Detection::Collection :best sorting

            pixel_count = best_face.width * best_face.height
            magick_image = Manipulator.load_magick(@tempfile.path)

            expect(pixel_count).to eq magick_image.columns * magick_image.rows
          end

        end
      end
      
      context 'cropping' do 
        it 'should allow close cropping'
        it 'should take in percentages and weights'
        # crop_to_object -10, -20
      end


        it 'should' do 
          pending 'what'
          @image.clipped? # to eq true
          @image.clips # to be an array
          @image.clips # to eq CV thingy

#           # API:
#           img = @image.new(@fname) 
#           img.clip_face 
#           img.write do |f|
# # etc          do |f|
#             f.clip_face  # -d face
#             f.bw  # --bw
#             f.resize_to_fill(100, 200)  # --fill 100,200
#             f.write(whatev)
#           end

# yearbook photo.jpg face.jpg --clip face 

        end



    end
  end
end