class CodechallengeController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.codechallenge_id.nil?
      @codechallenge = Codechallenge.first
    else
      @codechallenge = Codechallenge.nextChallenge(current_user.codechallenge_id)
    end
  end

  def update
      attempt = params[:codechallenge_attempt]
      @codechallenge = Codechallenge.find(params[:id])

      if @codechallenge.compare_problem_to attempt
        @eval_result = @codechallenge.eval_and_run_test_code attempt
        if @eval_result.match(/true/).present?
            flash[:notice] = "Congratz! Let's try the next challenge :)"
            current_user.setChallenge(@codechallenge)
            redirect_to :action => :index
        else
            @codechallenge.problem = attempt
            flash[:notice] = "Try to get this test to return valid: #{@codechallenge.test_code}"
            flash[:notice] += "\nExecute result: #{@eval_result}"
            render :index
        end
      else
        @codechallenge.problem = attempt
        render :index
      end

  end

  def show
    redirect_to :action => :index
  end
end
