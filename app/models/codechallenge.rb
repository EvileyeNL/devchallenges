class Codechallenge < ActiveRecord::Base

  def self.nextChallenge(id)
    self.where('id > ?', id).first
  end

  def compare_problem_to(attempt)
    unless self.solution == attempt
      command = "ruby -c << EOF\n#{attempt} \nEOF"
      execute_result = ""
      Open3.popen2e(command){|stdin,out|
        out.each{ |line|
          execute_result += line
        }
      }
      # TODO: regex the /tmp/file.rb:1 part in execute_result
      if execute_result.match(/Syntax OK/).present?
        return true
      else
        return execute_result
      end
    else
      return true
    end
  end

  def eval_and_run_test_code(attempt)
    run_ruby_code(attempt, self.test_code)
  end

  private

  def run_ruby_code(attempt, test_code)
    command = "ruby << EOF\n#{attempt}\np (#{test_code})\nEOF"
    execute_result = ""
    Open3.popen2e(command){|stdin,out|
      out.each{ |line|
        execute_result += line
      }
    }
    # TODO: regex the /tmp/file.rb:1 part in execute_result
    return execute_result
  end

end
