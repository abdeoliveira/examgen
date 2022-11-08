class ROTATION

  def initialize(exam_number,questions)
    file = "../session/#{exam_number}.rot"
    questions.each do |q|
      q = q.sub("../input/","")
      File.write(file,"#{q}\n",mode:'a')
    end
  end

end
