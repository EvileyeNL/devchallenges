require 'Open3'
require 'spec_helper'

describe Codechallenge do
  before {
    @codechallenge_first = create :codechallenge, name: 'First challenge'
  }

  describe '.nextChallenge' do
    subject { Codechallenge.nextChallenge(@codechallenge_first) }
    let!(:codechallenge_second) do
      create :codechallenge, name: 'Second challenge'
    end
    context "returns next challenge" do
      it { should eq codechallenge_second }
    end
  end

  describe 'compare_problem_to' do
    let!(:valid_solution) do
      "def multiply(a, b)\r\n  a * b\r\nend"
    end
    let(:invalid_syntax_solution) do
      "def multiply(a b)\r\n  a * b\r\nend"
    end
    it 'returns true to a valid solution' do
      assert(@codechallenge_first.compare_problem_to(valid_solution), true)
    end
    it 'returns a string to a invalid syntax solution' do
      assert_equal(@codechallenge_first.compare_problem_to(invalid_syntax_solution), "-:1: syntax error, unexpected tIDENTIFIER, expecting ')'\ndef multiply(a b)\r\n                ^\n")
    end
  end

  describe "eval_and_run_test_code" do
    let!(:valid_solution) do
      "def multiply(a, b)\r\n  a * b\r\nend"
    end
    let(:invalid_code_solution) do
      "def multiply(a, b)\r\n  a * b * 10\r\nend"
    end
    it 'returns true to a valid solution' do
      assert(@codechallenge_first.eval_and_run_test_code(valid_solution), true)
    end
    it 'returns a string to a invalid solution' do
      assert_equal(@codechallenge_first.eval_and_run_test_code(invalid_code_solution), "false\n")
    end
  end
end
