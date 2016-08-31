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
		@game.update_attribute(:questions, rand(1000..9999))
		render 'creater_question_form'
	end

	def creater_validate_question
		unless session[:quiz]
		 	session[:quiz] = 'q1'
		 end
		@questions = @game.questions.to_s.split("")
		case session[:quiz]
		 when 'q1'
		 	@question_num = Question.find(@questions[0].to_i)
		 when 'q2'
		 	@question_num = Question.find(@questions[1].to_i)
		 when 'q3'
		 	@question_num = Question.find(@questions[2].to_i)
		 when 'q4'
		 	@question_num = Question.find(@questions[3].to_i)
		 when 'finish'
		 	flash[:notice] = 'Игра окончена'
		 else
		 	flash[:error] = 'Упс что-то пошло не так начните игру заново'
		 	controller.redirect_to my_games_path
		 end
	end
end
