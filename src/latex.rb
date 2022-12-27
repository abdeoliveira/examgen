class LATEX

#===NEW EXAM - WRITE HEADER========
    
    def newdoc(output,examnumber,build)
      ##LOCALE
      header = File.read('../aux/header_en.tex')
      #header = File.read('../aux/header_en.tex')
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
          #alts[i]=alts[i].to_s.sub('.',',')
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
      formulas = File.read('../aux/formulas.tex')
      File.write(output,formulas,mode:'a')
    end

#==========WRITE MATRICULA EXAMPLE (IMAGE)=======

    def printmatriculaimage(output)
      image='../aux/matricula.png'
      include_image="\\\includegraphics[width=6cm]{#{image}}\\\\\n"
      File.write(output,include_image,mode:'a')
    end

#===WRITE STUDENT INFORMATION (TEXT)==

    def printmatriculatext(output)
      textmatricula = File.read('../aux/text-matricula.tex')
      File.write(output,textmatricula,mode:'a')
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
