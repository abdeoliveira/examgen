require './crop'
require './extract'
require './compare'
require './report'
require './warning'
require './statistics'
#===========MARKFORM SIDE==============
unless ARGV[0]=='left' or ARGV[0]=='right' 
  puts "Usage: 'ruby correction.rb <side>', where <side> = 'left' or 'right'."
  abort
end
#============SOME READINGS=============
scanned_exams = Dir["./IMAGES/Scan*.*"].sort!
list = '../session/diario_classe.csv'
logfile = '../session/session.log'
files = Dir['../session/*.gnxs']
ignore_file = '../session/qignore'
ignore = 'none'
if File.exist? ignore_file
  ignore = File.read(ignore_file).strip
end
#==A FEW INITIALIZATIONS/DEFINITIONS=====
File.write(logfile,"",mode:'w')
num_images = scanned_exams.length
report = REPORT.new
count = Hash.new(0)
stat = Hash.new
files.each do |f|
  stat[f]=0
end
#============================
puts "NUMBER OF FILES: #{num_images}"
scanned_exams.each.with_index do |file,m|
    crop = CROP.new(file,ARGV[0])
    image = crop.image
    index = crop.index
    extract = EXTRACT.new(image)
    examid = extract.examid
    ans = extract.ans
    stuid = extract.stuid
    errors = extract.errors
    if errors[0] 
      score='?'
      examid='?'
    else
      compare = COMPARE.new(examid,ans,stat,ignore)
      score = compare.score
      stat = compare.stat
    end
    count[stuid]+=1
    warning = WARNING.new(stuid,ans,errors,count,ignore)
    check = warning.obs
    report.export(score,stuid,examid,list,index,check)
    log = "File:#{index}, #{ans.inspect}, ID:#{stuid}, Exam:#{examid}, Score:#{score}, Warnings:#{check}"
    puts log
    File.write(logfile,"#{log}\n",mode:'a')
end
unless num_images==0 then STATISTICS.new(stat,logfile,num_images,ignore) end
#==========================
