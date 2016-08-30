class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:edit, :update, :new, :index]
  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    gon.watch.game_status = @game.status
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  #def edit
  #end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new
    @game.creater = current_user.username
    @game.status = 0
    if params[:game][:opponent] == ''
      random_opponent
    elsif @user_opponent = User.find_by(username: params[:game][:opponent])
      case @user_opponent.status
      when 0 then
        flash.now[:error] = 'Этот пользователь не в сети'
        render :new
      when 1 then
        @game.opponent = params[:game][:opponent]
        c_user = User.find_by(username: current_user.username)
        c_user.status = 2
        c_user.save
        session[:game] = 'creater'
        game_save
      else
        flash.now[:error] = 'Этот пользователь в игре'
        render :new
      end
    else
      flash.now[:error] = 'Такого пользователя не существует'
      render :new
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:opponent)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Пажалуйста, войдите в свой аккаунт"
      end
    end

    def game_save
      if @game.save
        redirect_to @game, notice: 'Игра создана'
      else
        render :new
      end
    end

    def random_opponent
      c_user = User.find_by(username: current_user.username)
      c_user.update_attribute(:status, 2)
      if opponent = User.find_by(status: 1)
        @game.opponent = opponent.username
        session[:game] = 'creater'
        game_save
      else
        c_user = User.find_by(username: current_user.username)
        c_user.update_attribute(:status, 1)
        flash.now[:error] = 'Нету свободных пользователей'
        render :new
      end
    end
end
