require './import'
require './checkdata'
require './latex'
require './form'
require './numericalts'
require './textalts'
require './limits'
require './keys'
require './janitor'
require './minmax'
require './rotation'
#======== ADJUST THIS BEFORE RUNNING============

nalts = 5
num_exams = 38
q_in_line = 10 # For the form.rb. Currently only 10 is allowed

#==========THE JANITOR OPENS THE SCHOOL===============

janitor = JANITOR.new

#============SCAN FOR GNXS FILES=======================

files = Dir['../input/*.gnxs']
num_quests = files.length

#===========CHECK FOR CODE'S LIMITATIONS==============

LIMITS.new(nalts,num_exams,files)

#==============LOOP OVER EXAMS====================
exam_index=[*'00001'..num_exams.to_s]
texfile = '../session/temp'
num_exams.times do |j|

  files = files.shuffle # Scramble questions among exams ;-)
  examnumber = ['\#',j+1].join

#===========INITIALIZE SOME LATEX STUFF=================

  jj = exam_index[j]
  output = [texfile,"_#{jj}.tex"].join
  latex = LATEX.new
  latex.newdoc(output,examnumber)

#=======WRITE ROTATED QUESTIONS TO FILES========================
  
  ROTATION.new(j+1,files)

#===========LOOP OVER GNXS FILES=======================

  files.each.with_index do |f,q_index|                                               

#----------IMPORT QUESTIONS DATA--------------------------

    item = IMPORT.new(f)
    q    = item.question
    ans  = item.answer
    conf = item.configuration
    file = item.file
    fig  = item.figure
    
#----------(BASIC) CHECK FOR INTEGRITY OF IMPORTED DATA-----------

    chkdata = CHECKDATA.new(q,ans,conf,file,fig,nalts)

#---BUILD ALTERNATIVES, NUMERIC QUESTION, AND CORRECT ANSWER-----

   if conf['mode']=='numeric' 
     vars = chkdata.variables
     nvars = chkdata.nvar
     numcalts = NUMERICALTS.new(q,ans,vars,nvars,nalts,f,q_index,j+1)
     q = numcalts.subquest
     alts = numcalts.alternatives
     okans = numcalts.okans
   end

   if conf['mode']=='text'
     txtalts = TEXTALTS.new(ans,nalts)
     alts = txtalts.alternatives
     okans = txtalts.okans
   end
#----------WRITE KEYS TO FILE-----------------------

   KEYS.new(j+1,alts,okans)

#----------MORE LATEX STUFF------------------------------------

    inline = conf['inline'].to_i
    mode = conf['mode']
    latex.printquest(output,q,q_index,fig)
    latex.printalts(output,nalts,inline,alts,mode)
   
#--------------------------------------------------------  
  end

#===========CLOSE DOCUMENT #j===============================
  
  latex.printformulas(output)
  latex.printmatriculaimage(output)
  latex.pagebreak(output)
  FORM.new(q_in_line,num_exams,nalts,num_quests,output,j) #Print Form for students answers and ID
  latex.printmatriculatext(output)
  latex.closedoc(output)

end  
#==========THE JANITOR CLOSES THE SCHOOL====================

janitor.close(num_exams,num_quests,nalts,q_in_line)

#===============================


