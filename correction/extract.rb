class EXTRACT
  def initialize(image)
#==============================
    tol_quest = 0.3 # FOR QUESTIONS
    tol_stuid = 0.1
    tol_examid = 0.6 # FOR EXAM ID
#==============================
  auxdata = File.readlines('../session/auxfile').first.split(' ')
  num_exams = auxdata[0].to_i
  num_quest = auxdata[1].to_i
  num_alts  = auxdata[2].to_i
  q_in_line = auxdata[3].to_i
  ndigits = num_exams.digits.count
  factor = (num_quest.to_f/q_in_line).ceil
  num_lines = ndigits + factor*(num_alts+1) + 8 + 3
  num_cols = q_in_line + 1
  pixels = image.get_pixels
  dx = (image.width.to_f/num_cols).floor
  dy = (image.height.to_f/num_lines).floor
#====BLACK PIXEL FUNCTION===========
  def black_pixel(l,c,pixels)
    red   = pixels[l][c][0]
    green = pixels[l][c][1]
    blue  = pixels[l][c][2]
    white = (red + green + blue).to_f/765
    black = 1 - white
    return black
  end
#====LINE CORRECTION FUNCTION=======
def line_correction(f)
  return (f*1.025).round
end
#==============QUESTIONS============
    alphabet=[*'a'..'z']
    ans = Array.new(num_quest,'blank')
      num_quest.times do |i|
        f = i/q_in_line
        x = (i+1)*dx + dx/2 - f*q_in_line*dx 
        x = line_correction(x)
        q_count = 0
        num_alts.times do |j|  
          y = f*(num_alts+1)*dy + (j+ndigits+3)*dy + dy/2 
          y = line_correction(y)
         #puts "#{x} #{y}" 
          count = 0
          black = 0
          (y-dy/4).upto(y+dy/4) do |l|
            (x-dx/4).upto(x+dx/4) do |c|
                count+=1
                black = black_pixel(l,c,pixels) + black
            end
          end
        if black/count > tol_quest then q_count+=1; ans[i] = alphabet[j] end
        if q_count > 1 then ans[i]='dupe' end
      end
    end
#===============STUDENT ID============
    student_error = false
    tol_stuid_new = tol_stuid
    stuid = Array.new(7,'?')
    7.times do |j|
      id_count=0
      y = (j+ndigits+(num_alts+1)*factor+4)*dy + dy/2 
      y = line_correction(y)
      10.times do |i|
        x = (i+1)*dx + dx/2  
        x = line_correction(x)
        #puts "#{x} #{y}"
        count = 0
        black = 0
        (y-dy/4).upto(y+dy/4) do |l|
          (x-dx/4).upto(x+dx/4) do |c|
           if c < image.width and l < image.height #AVOID c AND l TRESPASS IMAGE LIMITS
            count+=1
             black = black_pixel(l,c,pixels) + black
           end
          end
        end
            if black/count > tol_stuid_new then id_count+=1; stuid[j] = i; tol_stuid_new = black/count end
      end
      #unless id_count==1 then student_error = true; stuid[j] = '?' end
      tol_stuid_new = tol_stuid
    end
#===========EXAM ID===================
  exam_error = false
  examid = 0
  ndigits.times do |n|
    dig_count=0
    y = (n+1)*dy + dy/2  
    y = line_correction(y)
    10.times do |i|
      x = (i+1)*dx + dx/2 
      x = line_correction(x)
      #puts "#{x} #{y}"
      count = 0
      black = 0
      (y-dy/4).upto(y+dy/4) do |l|
        (x-dx/4).upto(x+dx/4) do |c|
          count+=1
          black = black_pixel(l,c,pixels) + black
        end
      end
      if black/count > tol_examid then dig_count+=1; examid = examid + i*10**n end
    end
    unless dig_count==1 then exam_error = true end
  end
  #============SOME METHODS==========
  @examid = examid
  def self.examid
    @examid
  end
  @ans = ans
  def self.ans
    @ans
  end
  @stuid = stuid
  def self.stuid
    @stuid
  end
  @errors=[exam_error,student_error]
  def self.errors
    @errors
  end
  #==================================
  end
end
