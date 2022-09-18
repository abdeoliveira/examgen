class TEXTALTS
  def initialize(ans,nalts)
#=============BUILD ALTERNATIVES=============================
    tarray=[]
    farray=[]
    i=0
    j=0
    ans.each do |k|
      if k[1]=="true"  then tarray[j]=" #{k[0]}"; j+=1 end
      if k[1]=="false" then farray[i]=" #{k[0]}"; i+=1 end
    end
    @alternatives=farray.sample(nalts-1)
    @alternatives[nalts-1] = tarray.sample
#===================SOME METHODS==============================    
    def self.alternatives
      @alternatives.shuffle
    end
    def self.okans
      @alternatives.last
    end
#=============================================================    
  end
end
