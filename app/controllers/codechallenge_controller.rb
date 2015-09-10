class CodechallengeController < ApplicationController

  def index
    @codechallenge = Codechallenge.first
    @execute_result = ""
  end

  def update
      current_id = params[:id]
      attempt = params[:codechallenge_attempt]
      @codechallenge = Codechallenge.find(current_id)
      @execute_result = ""

      unless Codechallenge.find(current_id).solution == attempt
        command = "ruby -c << EOF\r\n#{attempt} \r\nEOF"
        Open3.popen2e(command){|stdin,out,blub|
          out.each{ |line|
            @execute_result += line+"<br/>"
          }
        }
        # TODO: regex the /tmp/file.rb:1 part

        @codechallenge.problem = attempt
      else
        @execute_result = "Syntax OK"
        @codechallenge = @codechallenge.nextChallenge
      end
    render :index
  end
end
