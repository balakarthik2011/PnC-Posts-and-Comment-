# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('#posts-link').click ->
    $('#new-posts').slideToggle()
    $('#comment_body').focus()
