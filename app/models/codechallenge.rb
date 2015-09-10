class Codechallenge < ActiveRecord::Base

  def nextChallenge(current_id)
    self.class.where('id > ?', current_id).first
  def compare_problem_to(attempt)
    unless self.class.where(id: id).take.solution == attempt
      command = "ruby -c << EOF\r\n#{attempt} \r\nEOF"
      execute_result = ""
      Open3.popen2e(command){|stdin,out|
        out.each{ |line|
          execute_result += line+"<br/>"
        }
      }
      # TODO: regex the /tmp/file.rb:1 part
      return execute_result
    else
      return "Syntax OK"
    end
  end

end
