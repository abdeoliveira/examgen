require './dryrun'
class MINMAX
  def initialize(sample,ans)
    min = 1E10
    max = -1E10
    sample.times do |i|
      dryrun = DRYRUN.new(ans)
      ok = dryrun.correct
      if ok < min then min = ok end
      if ok > max then max = ok end
    end
#===========METHODS==========
    @minmax=[min,max]
    def self.range
      @minmax
    end    
  end
end
