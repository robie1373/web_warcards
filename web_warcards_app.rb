require 'sinatra'
require 'warcards'

configure do
  enable :sessions
end

get "/" do
  erb :index
end

get "/warcards/setup" do
  erb :setup
end

post '/warcards/verify' do
  @ls                     = Dir.glob "public/*"
  @demo_questions_file    = File.expand_path(Dir.glob("public/*.txt").first)
  session[:question_file] = @demo_questions_file
  session[:difficult]     = @difficulty
  session[:player_name]   = params[:player_name]
  @player_name            = session[:player_name]
  @params                 = params
  @filename               = params['filename']
  @difficulty             = params['difficulty']
  erb :verify
end

post '/warcards/play' do
  @params = params
  @answer = params['answer']
  erb :play_answer
end

get '/warcards/play' do

  #class Cardgame::Game
  #
  #  def output_web_fe(result)
  #    output.winner = result[:winner]
  #  end
  #
  #  def challenge_participants(result)
  #    if output.winner == @game_instance.player
  #      challenge_player(result)
  #    else
  #      challenge_ai(result)
  #    end
  #  end
  #
  #  def challenge_player(result)
  #    if test_player
  #      output.player_feedback = "Correct! Yay!"
  #    else
  #      output.player_feedback = "Oooh. I'm sorry. The correct answer was TODO. #{@game_instance.ai.name} became the winner."
  #      output.winner          = @game_instance.ai
  #    end
  #  end
  #
  #  def challenge_ai(result)
  #    if test_ai(@difficulty)
  #      output.ai_feedback = "Ai was correct."
  #    else
  #      output.ai_feedback = "Ai was incorrect. #{@game_instance.player.name} became the winner!"
  #      output.winner      = @game_instance.player
  #    end
  #  end
  #
  #  def test_player
  #    question     = @questions.sample
  #    output.posed = question.pose
  #    answer       = session[:this_answer] #TODO this is actually the correct answer. use session to bring back the player answer
  #    question.is_correct?(answer.chomp)
  #  end
  #
  #  def test_ai(difficulty)
  #    @game_instance.ai.difficulty_check?(rand, difficulty)
  #  end
  #end


  @game_instance = Cardgame::Game.new
  @questions     = Querinator::Game.new.get_questions(session[:question_file])
  @difficulty    = session[:difficulty]
  @player_name   = session[:player_name]
  erb :play
end
