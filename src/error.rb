class ERROR
  def initialize(examnumber,q_index,q,file)
    @examnumber=examnumber
    @q_index=q_index
    @file=file
    @q=q
#===============================
   #----DUPLICATE ALTERNATIVES------
    def self.duplicate(alternatives)
      if alternatives.uniq.length != alternatives.length
        puts "ERROR!"
        puts "Exam Number: #{@examnumber}"
        puts "QUESTION: #{@q_index+1}. #{@q[0..40]}...\n"
        puts "DUPLICATE ALTERNATIVES FOUND: #{alternatives.inspect}"
        puts "FILE: #{@file}"
        puts "THIS IS PROBABLY DUE TO A SMALL RANGE IN YOUR QUESTION VARIABLES."
        puts "ALSO, YOU MAY HAVE TOO MUCH ALTERNATIVES."
        puts "PROCESS ABORTED"
        abort
      end
    end
    #-----MISSING THE CORRECT ALTERNATIVE-----
    def self.missing(found,alternatives,okansd)
      unless found
        puts "ERROR!"
        puts "Exam Number: #{@examnumber}"
        puts "QUESTION: #{@q_index+1}. #{@q[0..40]}...\n"
        puts "CORRECT ANSWER (#{okansd}) MISSING IN ALTERNATIVES: #{alternatives.inspect}"
        puts "FILE: #{@file}"
        puts "DAMN IT! THIS IS MOST LIKELY A BUG."
        puts "PROCESS ABORTED"
        abort
      end
    end
    #----Check if the correct answer lies inside the user-given interval--
    def self.outrange(okans,okansd,okmin,okmax,auto_minmax)
      message = "THE CORRECT ANSWER (#{okansd}) LIES OUTSIDE THE GIVEN INTERVAL [#{okmin.to_f.round(1)},#{okmax.to_f.round(1)}]"
      if okans < okmin or okans > okmax
        unless auto_minmax
          puts "WARNING:"
          puts "Exam Number: #{@examnumber}"
          puts "QUESTION: #{@q_index+1}. #{@q[0..40]}...\n"
          puts message
          puts "FILE: #{@file}"
          puts "THIS IS JUST A WARNING. NOTE THAT THE CORRECT ANSWER MAY BE SPOTTED BY A KEEN STUDENT."
          puts "THE PROGRAM WILL CONTINUE."
          puts "==============="
        end
      end
    end
#=======================
  end
end
