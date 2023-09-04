#!/usr/bin/ruby
#require 'parallel'
require './crop'
require './extract'
require './compare'
require './report'
require './warning'
require './statistics'
#=====================================
images_path = './IMAGES/'  
#===========MARKFORM SIDE==============
unless ARGV[0]=='l' or ARGV[0]=='r' 
  puts "Usage: 'ruby correction.rb <side> <pattern>', \n\
  where <side> = 'l' or 'r'."
  abort
end
side = ARGV[0]
#============SOME READINGS=============
if ARGV[1].nil? then puts 'ABORTING: Please provide a <pattern> argument'; abort end
scanned_exams = Dir[images_path+ARGV[1]+"*"].sort!
session_path = '../session/'
list = session_path+'diario_classe.csv'
logfile = session_path+'session.log'
quest_files = Dir[session_path+'*.gnxs']
ignore_file = session_path+'qignore'
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
quest_files.each do |f|
  stat[f]=0
end
#============================
puts "NUMBER OF FILES: #{num_images}"
#Parallel.each(scanned_exams,in_processes: 4) do |file|
scanned_exams.each do |file|
    ff = file.sub(images_path,'')
    cropped_file = images_path+'cropped.'+ff
    unless File.exist? cropped_file
      crop = CROP.new(file,side,cropped_file)
    end
    extract = EXTRACT.new(cropped_file)
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
    report.export(score,stuid,examid,list,ff,check)
    puts log = "File:#{ff}, #{ans.inspect}, ID:#{stuid}, Exam:#{examid}, Score:#{score}, Warnings:#{check}"
    File.write(logfile,"#{log}\n",mode:'a')
end
unless num_images==0 then STATISTICS.new(stat,logfile,num_images,ignore) end
#==========================
