class PagesController < ApplicationController
	def index
		@a = Question.all
	end
	def valid
		@an = params[:q][:answer]
		redirect_to pages_new_path
	end
	def new
	end
end
