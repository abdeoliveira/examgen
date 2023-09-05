class STATISTICS
  def initialize(logfile,num_images,ignore,stat_file,num_quests)
    total = num_images*(num_quests - ignore.split(',').length)
    nra = `wc -l #{stat_file}`.to_i
    count = Hash.new(0)
    puts title="=============STATISTICS============\n"
    File.write(logfile,title,mode:'a')
    File.readlines(stat_file).each do |k|
      count[k.strip]+=1
    end
    count.sort_by{|k,v|v}.reverse.each do |k,v|
      percent = v.to_f/num_images
      puts data="#{percent.round(2)} #{k} (#{v})"
      File.write(logfile,"#{data}\n",mode:'a')
    end
    puts final = "-----------------\nOverall average: #{(nra/total.to_f).round(3)}\n-----------------\n"
    File.write(logfile,final,mode:'a')
  end
end
