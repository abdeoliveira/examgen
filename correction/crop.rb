require 'mini_magick'
class CROP
  def initialize(file)
  #------------------------
    frame_tol  = 0.5    # tolerance for frame's black color
    left = true
  #-----------------------
#=========IMPORT RAW IMAGE======================  
    image = MiniMagick::Image.open(file)
    pixels = image.get_pixels
    index = file.scan(/\d+/).first #retrieve file number, e.g. 'Scan 0.png' => 0
    format = file.split('.')[2] #retrieve file format, e.g. 'Scan 0.png' => png
#=========BLACK PIXEL MEASUREMENT================
  def black_pixel(l,c,pixels)
    red   = pixels[l][c][0]
    green = pixels[l][c][1]
    blue  = pixels[l][c][2]
    white = red + green + blue
    white = white.to_f/765
    black = 1 - white
    return black
  end
#==========CROP TO A QUARTER==========================
    finetune = 10 # To account for columns separation. '+' cuts towards right. 
    x = image.width/2 + finetune 
    if left then x = 0  end
    image.crop "#{image.width/2}x#{image.height/2}+#{x}+0"
    pixels = image.get_pixels
    #image.write "./IMAGES/cropped_#{index}.#{format}"
    #abort
#=============FIND WIDTH (BEFORE ROTATION)=========================
    l = image.height/2
    c_min = image.width
    c_max = 0
      image.width.times do |c|
          if black_pixel(l,c,pixels) > frame_tol
            if c < c_min then c_min = c end
            if c > c_max then c_max = c end
          end
      end
#===========FIND ANGLE AND ROTATES==================
    delta = 100
    yaxis = Array.new
    xaxis = [c_min+delta,c_max-delta]
    xaxis.each.with_index do |c,j|
      image.height.times do |l|
          if black_pixel(l,c,pixels) > frame_tol
            yaxis[j]=l
            break
          end
      end
    end
    dx = (xaxis[1] - xaxis[0]).to_f
    dy = (yaxis[1] - yaxis[0]).to_f
    convert = 180.0/Math::PI
    angle = convert*Math.atan(dy/dx)
    image.rotate(-angle)
    pixels = image.get_pixels
     #image.write "./IMAGES/cropped_#{index}.#{format}"
     #abort
#==============FIND HEIGHT======================  
    c = image.width/2
    l_min = image.height
    l_max = 0
      image.height.times do |l|
          if black_pixel(l,c,pixels) > frame_tol 
            if l < l_min then l_min = l end
            if l > l_max then l_max = l end
          end
      end
#=============FIND WIDTH=========================
    l = image.height/2
    c_min = image.width
    c_max = 0
      image.width.times do |c|
          if black_pixel(l,c,pixels) > frame_tol
            if c < c_min then c_min = c end
            if c > c_max then c_max = c end
          end
      end
#=============FINAL CROP==========================
      del_c = c_max - c_min
      del_l = l_max - l_min
      image.combine_options do |c|
        c.repage.+
        c.crop "#{del_c}x#{del_l}+#{c_min}+#{l_min}" 
      end
      image.write "./IMAGES/cropped_#{index}.#{format}"
#==============================================
      @image = image
      def self.image
        @image
      end
      @index = index
      def self.index
        @index
      end
#==============================================
  end
end
