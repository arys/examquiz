class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init

  include SessionsHelper
  include GamesHelper

  def init
    @invites = Game.where(opponent: current_user.username)
    @my_games = Game.where(creater: current_user.username)
    @notifications = @invites.size + @my_games.size
  end
end
