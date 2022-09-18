class CHECKDATA

  def initialize(q,ans,conf,file,fig,nalts)

#=========SOME INITIAL STUFF=================
  @variables = q.scan(/@VAR\((\w+)\)/)
  @nvar    = @variables.length
  nvarans = ans.length - 2
  
    def self.variables
      @variables
    end

    def self.nvar
      @nvar
    end
#========== CONFIG ===========================
  conf_keys = ['mode','inline']
  conf_keys.each do |k|
    unless conf.key?(k) then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@config'.\nMISSING '#{k}' ENTRY.\nABORTING."; abort end
  end
#========== QUESTION ==========================
  if q.nil? or q.empty? then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@question'.\nMISSING QUESTION.\nABORTING.";abort end
#=========== FIGURE ===========================
  fig_keys = ['file','width']
  fig_keys.each do |k|
    unless fig.key?(k) then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@figure'.\nMISSING '#{k}' ENTRY.\nABORTING."; abort end
  end
#=========== VARIABLES =======================
  if conf['mode']=='numeric'
    unless nvarans == @nvar 
      puts "WARNING!\nFILE '#{file}'."+
      "\nBLOCKS '@question' AND '@answer'."+
        "\nNUMBER OF VARIABLES ARE DIFFERENT."+
        "\nCONTINUING..."+
        "\n============================"
    end
      @variables.each do |v|
        var = v[0]
        unless ans.key?(var) then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@question'.\nVARIABLE '#{var}' NOT DECLARED.\nABORTING.";abort end
    end
      ans.each do |k,v|
        unless k=='correct' or k=='minmax'
          k="$#{k}"
          unless ans['correct'].include?(k) 
            puts "WARNING!\nFILE '#{file}'.\nBLOCK '@answer'."+
            "\nMISMATCH BETWEEN DECLARED AND USED VARIABLES IN 'correct' ENTRY."+
            " PERHAPS #{k}?"+
            "\nCONTINUING..."+
            "\n============================"
          end
        end
      end
  end
#============ ANSWER =========================
  if conf['mode']=='numeric'
    unless ans.key?('correct') then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@answer'.\nMISSING 'correct' ENTRY.\nABORTING.";abort end
    unless ans.key?('minmax') then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@answer'.\nMISSING 'minmax' ENTRY.\nABORTING.";abort end
  end
  #------------------------------------------
  if conf['mode']=='text'
    nf=0
    nt=0
    ans.each do |k,v|
      if v=='false' then nf+=1 end
      if v=='true'  then nt+=1 end
    end
    if nt == 0 then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@answer'.\nMISSING A 'true' ALTERNATIVE IN TEXT MODE.\nABORTING.";abort end
    if nf < (nalts-1) then puts "ERROR!\nFILE '#{file}'.\nBLOCK '@answer'.\nONLY #{nf} 'false' ALTERNATIVES FOR A #{nalts} ALTERNATIVES QUESTION.\nABORTING.";abort end
  end
#============================================
  end

end
