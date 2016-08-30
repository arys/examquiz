module GamesHelper

	def validates
		if @game.status == 1 && session[:game] == 'creater'
			creater
		elsif @game.status == 1 && session[:game] == 'opponent'
			opponent
		else
			controller.redirect_to games_path
		end
	end

	def creater
		"I`m creater"
	end

	def opponent
		"I`m opponent"
	end
end
