class KEYS

  def initialize(exam_number,alts,okans)
    file = "../session/#{exam_number}.key"
    alphabet=[*'a'..'z']
    alts.each.with_index do |k,i|
       if k==okans then File.write(file,"#{alphabet[i]}\n",mode:'a') end
    end
  end

end
