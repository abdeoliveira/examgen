class WARNING
  def initialize(stuid,ans,errors,count)
    @obs=[]
    if errors[0] then @obs<<"Inconsistent Exam ID" end
    if errors[1] then @obs<<"Inconsistent Student ID" end
    if count[stuid] > 1 then @obs<<"Duplicate Student ID" end
    if ans.include? 'blank' then @obs<<"Blank question(s)" end
    if ans.include? 'dupe' then @obs<<"Dupe question(s)" end
    def self.obs
      @obs
    end
  end
end
