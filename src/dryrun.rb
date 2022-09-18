class DRYRUN
  def initialize(ans)
  subvar = Hash.new
#========SUBSTITUTE RANDOM NUMBERS INTO VARIABLES===============    
    ans.each do |k,v|
      unless k=='correct' or k=='minmax' 
          i = v.split(",")[0].to_f
          f = v.split(",")[1].to_f
          d = v.split(",")[2].to_i
          subvar[k] = rand(i...f).round(d)
      end
    end  
#============CALCULATE THE CORRECT ANSWER=====================
    c = ans['correct']
    subvar.each do |k,v|
      k = ['$',k].join
      v = v.to_f.to_s
      c = c.gsub(k,v)
    end
    @okans = eval(c)
#==========RETURN THE CORRECT ANSWER=========    
    def self.correct
      @okans
    end
#==========
  end
end
