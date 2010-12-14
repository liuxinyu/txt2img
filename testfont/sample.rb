require 'rubygems'
require 'RMagick'
include Magick

# load the template
template = Image.read('template.png').first

# load an image as our 'Main Image'
photo = Image.read("user_image.jpg").first

# resize photo to fit within template
photo.crop_resized!(710,200)

# composite photo over template offsetting 10x10 for the template border
template.composite!(photo, 10, 10, OverCompositeOp)

# save composite image to JPG
template.write("collage.jpg")