class JANITOR

  def initialize
    session = Dir.exists? "../session"
    if session
      puts "There is already a running session. ABORTING."
      abort
    else
      `mkdir ../session`
    end
  end

  def close(numexams,numquests,nalts,qline)
    auxfile = '../session/auxfile'
    exam_index=[*'00001'..numexams.to_s]
    file='../session/script'
    File.write(file,'',mode:'w')
    numexams.times do |i|
      jj = exam_index[i]
      cmd = "pdflatex temp_#{jj}.tex\n"
      File.write(file,cmd,mode:'a')
    end
    #--------------------------
     cmd = "pdfunite temp_*pdf output.pdf"
     File.write(file,cmd,mode:'a')
    `chmod +x #{file}`
    #---------------------------
    auxdata="#{numexams} #{numquests} #{nalts} #{qline}"
    File.write(auxfile,auxdata,mode:'w')
  end

end
