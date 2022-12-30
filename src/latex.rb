class LATEX

#===NEW EXAM - WRITE HEADER========
    
    def newdoc(output,examnumber,build)
      ###LOCALE
      header = File.read('../aux/header_en.tex')
      if ENV['EXAMGEN_LOCALE']=='ptbr' then header = File.read('../aux/header_ptbr.tex') end
      header = header.sub('@EXAMID',examnumber)
      header = header.sub('@BUILD',build)
      File.write(output,header,mode:'w')
    end

#===========WRITE QUESTION========
    
    def printquest(output,quest,qindex,fig)
      qindex = qindex+1
      qindex = [qindex,"."," "].join
      quest = [qindex,quest,"\\\\","\n"].join
      File.write(output,quest,mode:'a')
      file=fig['file']
      size=fig['width']
      include_fig="\\\includegraphics[width=#{size}]{../input/figs/#{file}}\\\\\n"
      unless file=='none' 
        File.write(output,include_fig,mode:'a')
      end
    end

#=========WRITE ALTERNATIVES======
    
    def printalts(output,nalts,inline,alts,mode)
      alphabet=[*'(a)'..'(z)']
      nalts.times do |i|
        if mode=='numeric' 
          ###LOCALE
          if ENV['EXAMGEN_LOCALE']=='ptbr' then alts[i]=alts[i].to_s.sub('.',',') end
        end
        if (i+1)%inline!=0 
          alt = [alphabet[i],alts[i],"~","\n"].join 
        end
        if (i+1)%inline==0 or i+1==nalts
          alt = [alphabet[i],alts[i],"\\\\","\n"].join
        end
        File.write(output,alt,mode:'a')
      end
      File.write(output,"\n",mode:'a')
    end

#=========WRITE FORMULAS==========

    def printformulas(output)
      inputfile = '../input/formulas'
      formulas = File.read('../aux/skel_formulas.tex')
      if File.exist?(inputfile) then
        File.readlines(inputfile).each_with_index do |line,index|
          if index==0
            formulas.sub!('@TITLE',line.strip)
          else 
            line =  '&' + line.strip + '&\\\\\\'
            formulas.sub!('%@ENTRY',line+"\n%@ENTRY")
          end
        end
      else
        formulas = " "
      end
      File.write(output,formulas,mode:'a')
    end

#==========WRITE STUDENT ID EXAMPLE (IMAGE)=======

    def printstuidimage(output)
      ###LOCALE
      image='../aux/studentidimage_en.png'
      if ENV['EXAMGEN_LOCALE']=='ptbr' then image='../aux/studentidimage_ptbr.png' end
      include_image="\\\includegraphics[width=7cm]{#{image}}\\\\\n"
      File.write(output,include_image,mode:'a')
    end

#=======WRITE STUDENT ID INFORMATION (TEXT)==

    def printstuidtext(output)
      ###LOCALE
      textstuid = File.read('../aux/studentidtext_en.tex')
      if ENV['EXAMGEN_LOCALE']=='ptbr' then textstuid = File.read('../aux/studentidtext_ptbr.tex') end
      File.write(output,textstuid,mode:'a')
    end

#====PAGEBREAK=====================
    def pagebreak(output)
      vfill='\vfill'
      pgbreak='\pagebreak'
      File.write(output,"#{vfill}\n#{pgbreak}\n",mode:'a')
    end    

#=========CLOSE DOCUMENT==========

    def closedoc(output)
      close = '\end{document}'
      File.write(output,close,mode:'a')
    end

#=================================

end
