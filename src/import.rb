class IMPORT

 def initialize(item)  

#============COOL INITIALIZINGS========  
   @config = Hash.new
   @answer = Hash.new
   @figure = Hash.new
   @file   = item
#==============SOME NICE PARSINGS=======
   doc = File.read(@file)
   conf = doc.split('@config')[1].split('@question')[0].strip
   @quest = doc.split('@question')[1].split('@figure')[0].strip
   fig =  doc.split('@figure')[1].split('@answer')[0].strip
   ans =  doc.split('@answer')[1].split('@end')[0].strip
#===========IMPORT CONFIGURATIONS =======
   line = conf.split("\n")
   line.each do |l|
     k = l.split(":")[0].strip
     v = l.split(":")[1].strip
     @config[k]=v 
   end
  #==========IMPORT ANSWER==============
   line = ans.split("\n")
   cm = @config['mode']
   line.each do |l|
     k = l.split(":")[0].strip
     v = l.split(":")[1].strip
     if cm == 'numeric' then @answer[k]=v end
     if cm == 'text'    then @answer[v]=k end
   end
#============IMPORT FIGURE=============
   line = fig.split("\n")
   line.each do |l|
       k = l.split(":")[0].strip
       v = l.split(":")[1].strip
       @figure[k]=v 
   end
#==============SOME METHODS===========
  def self.question
    @quest
  end

  def self.configuration
   @config
  end

  def self.answer
   @answer
  end

  def self.figure
   @figure
  end

    def self.file
      @file
    end
 #==================================
  end
end


