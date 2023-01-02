class LATEX

#===NEW EXAM - WRITE HEADER========
    
    def newdoc(output,examnumber,build)
      header = File.read('../aux/header.tex')
      if File.exist? '../input/config/header' 
        config_header = File.read('../input/config/header')
        header.sub!('%@HEADER',config_header)
      end
      lang = File.read('../input/config/lang').split(',').to_a
      decimal = " "
      if lang[1].strip == 'comma' then decimal = '\mathcode`,="002C' end
      header.sub!('@LANG',lang[0].strip)
      header.sub!('@DECIMAL',decimal)
      header.sub!('@EXAMID',examnumber)
      header.sub!('@BUILD',build)
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
          lang = File.read('../input/config/lang').split(',')[1].strip
          if lang=='comma' then alts[i]=alts[i].to_s.sub('.',',') end
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
      inputfile = '../input/config/formulas'
      formulas = File.read('../aux/formulas.tex')
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
      image='../aux/studentidimage.png'
      example = File.read('../input/config/markform').split(',')[5].strip
      include_image=File.read('../aux/studentimage.tex')
      include_image.sub!('@EXAMPLE',example+':')
      File.write(output,include_image,mode:'a')
    end

#=======WRITE STUDENT NAME AND ID (TEXT)==

    def printstuidtext(output)
      textstuid = File.read('../aux/studentidtext.tex')
      markform = File.read('../input/config/markform').split(',').to_a
      textstuid.sub!('@NAME',markform[3].strip+':')
      textstuid.sub!('@STUID',markform[4].strip+':')
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
