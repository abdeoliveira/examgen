class LIMITS
  def initialize(nalts,numexams,files)
    #========MODIFY 'examid.tex' TO INCREASE MAX NUMBER OF EXAMS==================
    if numexams > 999 then puts 'MAX NUMBER OF EXAMS IS 999. ABORTED.';abort end 
    #=========FIND A NEW ALPHABET TO INCREASE THE MAX NUMBER OF ALTERNATIVES=======
    n = [*'a'..'z'].length  
    if nalts > n then puts "MAX NUMBER OF OF ALTERNATIVES IS #{n}. ABORTED.";abort end
    #==============================================================================
  end
end
