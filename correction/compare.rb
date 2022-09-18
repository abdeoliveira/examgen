class COMPARE
  def initialize(i,ans,stat)
    #========================
    rot = File.read("../session/#{i}.rot").split("\n")
    key = File.read("../session/#{i}.key").split("\n")
    score = 0
    ans.each.with_index do |a,j|
      if a==key[j] 
        score+=1 
        r = rot[j]
        stat[r]+=1
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
