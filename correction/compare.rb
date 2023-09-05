class COMPARE
  def initialize(i,ans,ignore,stat_file)
    #========================
    rot = File.read("../session/#{i}.rot").split("\n")
    key = File.read("../session/#{i}.key").split("\n")
    score = 0
    ans.each.with_index do |a,j|
      if a==key[j] 
        unless ignore.include? rot[j] or ignore.include? rot[j].sub('.gnxs','') 
          score+=1 
          File.write(stat_file,rot[j]+"\n",mode:'a')
        end
      end
    end
    #==========METHODS=======
    @score = score
    def self.score
      @score
    end
    #========================
  end
end
