# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
renewGameStatus = (status) ->
	if status == 0
		$('#game_status').text('Ожидание игрока...')
	else
		location.reload()

gon.watch('game_status', interval: 1000, renewGameStatus)
