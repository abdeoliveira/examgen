require './minmax'
require './error'
class NUMERICALTS
  def initialize(q,ans,variables,nvar,nalts,file,q_index,examnumber)
  error=ERROR.new(examnumber,q_index,q,file)
  subvar  = Hash.new
#========SUBSTITUTE RANDOM NUMBERS INTO VARIABLES===============    
    ans.each do |k,v|
      unless k=='correct' or k=='minmax' 
          i = v.split(",")[0].to_f
          f = v.split(",")[1].to_f
          d = v.split(",")[2].to_i
          subvar[k] = rand(i...f).round(d)
      end
    end
#========DEFINE MINMAX FOR ALTERNATIVES=======================    
    x = ans['minmax']
        if x.split(",")[0]=='auto'
            auto_minmax = true
            mm = MINMAX.new(100,ans)
            okmin=mm.range[0]
            okmax=mm.range[1]
            okdig=x.split(",")[1].to_i
        else
            i = x.split(",")[0].to_f
            f = x.split(",")[1].to_f
            d = x.split(",")[2].to_i
            okmin=i
            okmax=f
            okdig=d
        end
#=========SUBSTITUTE NUMERIC VARIABLES INTO QUESTION==========    
      ###LOCALE
      variables.each do |v|
      x = subvar[v[0]].to_s
      if ENV['EXAMGEN_LOCALE']=='ptbr' then x=x.sub('.',',') end
      s = ['@VAR(',v[0],')'].join
      q = q.sub(s,x)
    end
#============CALCULATE THE CORRECT ANSWER=====================
    c = ans['correct']
    subvar.each do |k,v|
      k = ['$',k].join
      v = v.to_f.to_s
      c = c.gsub(k,v)
    end
    okans = eval(c).to_f
    okansd = okans.round(okdig)
    okansd = "%.#{okdig}f" % okansd #Ensure that the correct answer has the right number of decimals. For example, 0.70 instead of 0.7. 
#============CHECKPOINT=====================================   
    error.outrange(okans,okansd,okmin,okmax,auto_minmax)
#=============BUILD ALTERNATIVES=============================
    @alternatives=[]
    offset = 0
    delta =1.001*(okmax-okmin).to_f/nalts
    third = delta/3
     nalts.times do |j|
      node = okmin+j*delta
      min = node-third
      max = node+third
      shadow = max + third
      if okans > max and okans < shadow  then offset = third end
     end    
    okmin = okmin+offset
    okmax = okmax+offset
    @found=false
    nalts.times do |j|
      node = okmin+j*delta
      min = node-third
      max = node+third
      rnd = rand(min...max)
      #--------Periodic boundary conditions----------
        if okans > 0 and rnd < 0 then rnd = okmax+j*third end
      #---------------------------------------------  
      @alternatives[j]="%.#{okdig}f" % rnd.round(okdig)
      unless @found
        if okans > min and okans < max or okans > okmax-third or okans < okmin 
          @found=true
          @alternatives[j]=okansd 
        end
      end
    end
#==========CHECKPOINT========================================
    error.duplicate(@alternatives)
    error.missing(@found,@alternatives,okansd)
#===================SOME METHODS==============================    
    def self.alternatives
      @alternatives.shuffle
    end
    @okans=okansd
    def self.okans
      @okans
    end
    @subquest=q
    def self.subquest
      @subquest 
    end
#=============================================================    
  end

end
