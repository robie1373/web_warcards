require "./lib/web_warcards/version"
require 'sinatra'
require 'warcards'
require 'sinatra/reloader' if development?

set :protection, :except => :ip_spoofing
@@questions = Querinator::Game.new.get_questions(File.expand_path(Dir.glob("public/*.txt").first))

configure do
  enable :sessions
end

@@game = Cardgame::Game.new

get "/" do
  erb :index
end

get "/about" do
  erb :about
end

#get "/warcards/favicon.ico" do
#  favicon.ico
#end

get "/warcards/setup" do
  erb :setup
end

post '/warcards/verify' do
  question_file         = File.expand_path(Dir.glob("public/*.txt").first)
  @@questions           = Querinator::Game.new.get_questions(question_file)
  session[:difficulty]  = @difficulty
  session[:player_name] = params[:player_name]
  @params               = params
  @filename             = params['filename']
  @difficulty           = params['difficulty']

  erb :verify
end

post '/warcards/play' do
  @params = params
  @answer = params['answer']
  erb :play_answer
end

get '/warcards/play' do
  @ai     = Cardgame::Ai.new
  @player = Cardgame::Player.new
  @deck   = Cardgame::Deck.new
  @deck.shuffle!
  session[:gameplay_instance] = Cardgame::Gameplay.new(:ai => @ai, :player => @player, :deck => @deck)
  session[:gameplay_instance].deal
  @difficulty = session[:difficulty]
  session[:gameplay_instance].game_over?
  session[:gameplay_instance].rearm?
  session[:gameplay_instance].show_cards
  session[:result] = session[:gameplay_instance].contest

  #def challenge_participants(result)
  #  if result[:winner] == session[:gameplay_instance].player
  #    challenge_player(result)
  #  else
  #    challenge_ai(result)
  #  end
  #end
  #
  #def challenge_player(result)
  #  if test_player
  #    #puts "Correct! Yay!"
  #  else
  #    #puts "Oooh. I'm sorry. The correct answer was #{session[:this_answer]}. #{session[:gameplay_instance].ai.name} became the winner."
  #    result[:winner] = session[:gameplay_instance].ai
  #  end
  #end
  #
  #def challenge_ai(result)
  #  unless test_ai(@difficulty)
  #    result[:winner] = session[:gameplay_instance].player
  #  end
  #end
  #
  #def test_player
  #  question = @@questions.sample
  #  answer   = gets
  #  question.is_correct?(answer.chomp)
  #end
  #
  #def test_ai(difficulty)
  #  difficulty ||= 0.4
  #  @ai.difficulty_check?(rand, difficulty)
  #end

  #challenge_participants(session[:result])
  erb :play
end
