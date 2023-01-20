class STATISTICS
  def initialize(stat,logfile,num_images)
    puts title="=============STATISTICS============\n"
    File.write(logfile,title,mode:'a')
    sumv = 0
    numq = stat.length
    stat.each do |k,v|
      v = (v.to_f/num_images).round(2)
      sumv = sumv + v
      k = k.sub("../session/","")
      if v==0 then v="0.00" end
      v = "%.2f"%v
      puts data="#{v} #{k}"
      File.write(logfile,"#{data}\n",mode:'a')
    end
    puts final = "-----------------\nOverall average: #{(sumv/numq).round(3)}\n-----------------\n"
    File.write(logfile,final,mode:'a')
  end
end
