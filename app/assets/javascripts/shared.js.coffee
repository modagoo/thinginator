$(document).on 'click', '.search-toggle', (event) ->
  $('form[role=search]').toggle()
  $('form[role=search] input[type=search]:first').focus()
  return false
