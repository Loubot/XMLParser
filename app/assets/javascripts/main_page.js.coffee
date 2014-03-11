# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#searchForm').submit (e) ->
    
    if $('.textInput').val() == 'E.G. dublin' || $('.textInput').val() == ''
      e.preventDefault()
      alert 'Please enter a vallue'