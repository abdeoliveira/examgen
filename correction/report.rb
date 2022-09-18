require 'csv'
class REPORT
  def initialize
    header="NAME;CLASS;ID;GRADE;EXAM;FILE;WARNING\n"
    File.write('../session/report.csv',header,mode:'w')
  end
  def export(score,stuid,examid,file,index,obs)
    @name={}
    @class={}
    CSV.foreach(file,:headers=>true, :col_sep=>';') do |c|
      mat=c['MATRICULA']
      @name[mat]=c['NOME']
      @class[mat]=c['TURMA']
    end
    id="#{stuid[0]}#{stuid[1]}.#{stuid[2]}.#{stuid[3]}#{stuid[4]}#{stuid[5]}#{stuid[6]}"
    if @name[id].nil? then obs<<"Missing NAME" end
    line="#{@name[id]};#{@class[id]};#{id};#{score};#{examid};#{index};#{obs.inspect}\n"
    File.write('../session/report.csv',line,mode:'a')
  end

end
