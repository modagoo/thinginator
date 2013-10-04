$(document).on 'click', '.search-toggle', (event) ->
  $(this).toggleClass('active')
  $('form[role=search]').toggle()
  $('form[role=search] input[type=search]:first').focus()
  return false
