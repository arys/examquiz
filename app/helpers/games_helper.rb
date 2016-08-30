module GamesHelper

	def validates
		if @game.creater == current_user.username
			creater
		elsif @game.opponent == current_user.username
			opponent
		else
			controller.redirect_to game_path
		end
	end

	def creater
		render 'creater_question_form'
	end

	def opponent
		@text = "I`m opponent"
	end

	def creater_validate_question
		unless session[:quiz]
		 	session[:quiz] = 'q1'
		 end
		@questions = @game.questions.to_s.split("")
		case session[:quiz]
		 when 'q1'
		 	@question_num = questions[1].to_i
		 when 'q2'
		 	@question_num = questions[2].to_i
		 when 'q3'
		 	@question_num = questions[3].to_i
		 when 'q4'
		 	@question_num = questions[4].to_i
		 else
		 	flash.notice[:error] = 'Упс что-то пошло не так начните игру заново'
		 	redirect_to my_games_path
		 end
	end

	def valid_answer
		if params[:q][:answer] == true
			@score = @game.creater_scores
			@game.update_attribute(:@game.creater_scores, @score  += 1)
			controller.redirect_to @game
		end
	end
end
