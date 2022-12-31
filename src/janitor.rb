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
     cmd1 = "pdfunite temp_*pdf output.pdf\n"
     cmd2 = "cp ../input/questions/*.gnxs .\n"
     File.write(file,cmd1,mode:'a')
     File.write(file,cmd2,mode:'a')
    `chmod +x #{file}`
    #---------------------------
    auxdata="#{numexams} #{numquests} #{nalts} #{qline}"
    File.write(auxfile,auxdata,mode:'w')
  end

end
