# Yearbook

A convenience for cropping and outputting images, by Dan Nguyen ([@dancow](https://twitter.com/dancow))

A very thin wrapper around [ruby-opencv](https://github.com/ruby-opencv/ruby-opencv) and [rmagick](http://rmagick.rubyforge.org/) (which themselves are wrappers around [OpenCV](http://opencv.org/) and [ImageMagick](http://www.imagemagick.org) + [GraphicsMagick](http://www.graphicsmagick.org/)) for producing face-cropped images from a source image.

This is in very-early stage...I'm using it mostly as a quickie image cropper for various projects, as well as a way to learn the cool [thor](https://github.com/erikhuda/thor) gem.

Has a few issues with painting-type images.

## Installation

Load all the dependencies mentioned above (ha!)

Then:

`gem install yearbook`

## Usage

### In Ruby

    require 'yearbook'
    
    image = Yearbook::Image.new('path/to/somebody.jpg')
    image.clip_and_print_best_face('output/to/somebodys-face.jpg')

### Command-line tool

    yearbook face george-washington.jpg
    # will print out to "george-washington-face.jpg" by default

