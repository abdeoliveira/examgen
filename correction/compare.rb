class COMPARE
  def initialize(i,ans,stat,ignore)
    #========================
    rot = File.read("../session/#{i}.rot").split("\n")
    key = File.read("../session/#{i}.key").split("\n")
    score = 0
    ans.each.with_index do |a,j|
      if a==key[j] 
        unless ignore.include? rot[j] or ignore.include? rot[j].sub('.gnxs','') 
          score+=1 
          r = '../session/'+rot[j]
          stat[r]+=1
        end
      end
    end
    #==========METHODS=======
    @stat=stat
    def self.stat
      @stat 
    end
    @score = score
    def self.score
      @score
    end
    #========================
  end
end
