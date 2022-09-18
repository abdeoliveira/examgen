require 'csv'

header = "NOME;MATRICULA;P1;P2;MF"
@name={}
@class={}
CSV.foreach('diario_classe.csv',:headers=>true, :col_sep=>';') do |c|
      mat=c['MATRICULA']
      @name[mat]=c['NOME']
      @class[mat]=c['TURMA']
end

@grade1={}
CSV.foreach('prova1.csv',:headers=>true, :col_sep=>';') do |c|
      id=c['ID']
      @grade1[id]=c['GRADE']
end

@grade2={}
CSV.foreach('prova2.csv',:headers=>true, :col_sep=>';') do |c|
      id=c['ID']
      @grade2[id]=c['GRADE']
end

puts header
@name.each do |k,v|
  final = (@grade1[k].to_f+@grade2[k].to_f)/2
  puts "#{v};#{k};#{@grade1[k]};#{@grade2[k]};#{final}"
end

