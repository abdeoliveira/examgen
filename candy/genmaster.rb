key_files = Dir["*.key"]
numexams = key_files.length
File.write('gabarito.txt',"",mode:'w')
numexams.times do |i|
  j=i+1
  letter = File.read("#{j}.key").split("\n")
  line = "#{j} #{letter}\n"
  File.write('gabarito.txt',line,mode:'a')
end
