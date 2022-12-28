class FORM

  def initialize(questions_in_line,numberofexams,naltern,noq,file,exam_number)
    if questions_in_line != 10 then raise "ERROR: CURRENTLY ONLY questions_in_line=10 (see forms.rb) IS ACCEPTBLE" end

#===============================================
  total_digs = numberofexams.digits.count

  factor = (noq.to_f/questions_in_line).ceil
  gaba_block=Array.new
  quest_block=Array.new
  alphabet = [*'a'..'z']

  factor.times do |f|
      gabarito = Array.new
      gaba_questions = '-- & q & q & q & q & q & q & q & q & q & q\tabularnewline'
      gaba_alternative ='@ & ? & ? & ? & ? & ? & ? & ? & ? & ? & ?\tabularnewline'
      run1 = questions_in_line
      if (f+1)==factor then run1=noq-f*questions_in_line end
#---QUESTIONS LINES---
      run1.times do |i|
        j = (i+1)+f*questions_in_line
        js = j.to_s
        #if j<10 then js=['0',j].join end
        gaba_questions=gaba_questions.sub('q',js)
      end
      gaba_questions=gaba_questions.gsub('q','--')

#---ALTERNATIVES LINES---
      naltern.times do |i|
        gabarito[i]=gaba_alternative.sub('@',alphabet[i])
          run1.times do |j|
           gabarito[i]=gabarito[i].sub('?',' ')
        end
        gabarito[i]=gabarito[i].gsub('?','--')
      end
      gaba_block[f]=gabarito
      quest_block[f]=gaba_questions
  end # factor loop

 
#---BUILD EXAM ID CODE---
      i = exam_number
      ###LOCALE
      examid = File.read('../aux/examid_en.tex')
      if ENV['EXAMGEN_LOCALE']=='ptbr' then examid = File.read('../aux/examid_ptbr.tex') end
      var = examid.scan(/(@D.\d.\d+)/)
      digs = (i+1).digits
      numd = digs.count
      left = total_digs - numd
      @swap=[]
      numd.times do |l|
        @swap[l] = "@D.#{l+1}.#{digs[l]}"
        examid=examid.gsub(@swap[l],'\black')
      end
      @zero=[]
      left.times do |l|
        l = l+numd
        @zero[l] = "@D.#{l+1}.0"
        examid=examid.gsub(@zero[l],'\black')
      end
 
 #---FILLING UNUSED CELLS WITH "--"
      var.each{|v|unless @swap.include? v[0] or @zero.include? v[0] then examid=examid.gsub(v[0],"--") end}
  
 #----DELETING UNUSED LINES--- 
      if numberofexams < 10 
        examid=examid.gsub('de&','%')
        examid=examid.gsub('\hline%de','')
        examid=examid.gsub('ce&','%')
        examid=examid.gsub('\hline%ce','')
      end  
      if numberofexams >= 10 and numberofexams < 100
        examid=examid.gsub('ce&','%')
        examid=examid.gsub('\hline%ce','')
      end
 #---------PRINT EXAM ID---------------

    if i+1 < 10 then exam_number = "00#{i+1}" end
    if i+1 >=10 and i<100 then exam_number = "0#{i+1}" end
    if i+1 >= 100 then exam_number = i+1 end
 
    File.write(file,examid,mode:'a')
 
 #-----PRINT ANSWERS TABLE------------
    hl = "\\hline\n"
    factor.times do |j| 
      qb = [quest_block[j],"\n"].join
      File.write(file,hl,mode:'a')
      File.write(file,qb,mode:'a')
        naltern.times do |i|
          gb = [gaba_block[j][i],"\n"].join
          File.write(file,hl,mode:'a')
          File.write(file,gb,mode:'a')
        end
    end   

#------------PRINT STUDENT ID TABLE--------------
    ### LOCALE
    stuid = File.read('../aux/studentid_en.tex') 
    if ENV['EXAMGEN_LOCALE']=='ptbr' then stuid = File.read('../aux/studentid_ptbr.tex') end
    File.write(file,stuid,mode:'a')

  end
end
