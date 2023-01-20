class STATISTICS
  def initialize(stat,logfile,num_images,ignore)
    num_ign = ignore.split(',').length
    puts title="=============STATISTICS============\n"
    File.write(logfile,title,mode:'a')
    sumv = 0
    numq = stat.length - num_ign
    stat.each do |k,v|
      v = (v.to_f/num_images).round(2)
      sumv = sumv + v
      k = k.sub("../session/","")
      if v==0 then v="0.00" end
      v = "%.2f"%v
      if ignore.include? k or ignore.include? k.sub('.gnxs','') then v = " IGN" end
      puts data="#{v} #{k}"
      File.write(logfile,"#{data}\n",mode:'a')
    end
    puts final = "-----------------\nOverall average: #{(sumv/numq).round(3)}\n-----------------\n"
    File.write(logfile,final,mode:'a')
  end
end
