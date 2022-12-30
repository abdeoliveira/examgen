      formulas = File.read('../aux/formulas.tex')
      File.readlines('../input/formulas').each_with_index do |line,index|
        if index==0
          formulas.sub!('@TITLE',line.strip)
        else 
          line =  '&' + line.strip + '&//'
          formulas.sub!('%@ENTRY',line+"\n%@ENTRY")
        end
      end
