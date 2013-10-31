$(document).on 'ready page:change', ->

  $('.prompted_other').hide()

  $('.prompted_other').each (i, e) =>
    if $(e).val() == ""
      $(e).prevAll('select.unlinked_list').val('Please select')
    else
      list_values = $(e).prevAll('select.unlinked_list').find('option').map(->
        $(this).val()
      )
      unless $.inArray($(e).val(), list_values) > -1
        $(e).show()
        $(e).prevAll('select.unlinked_list').val('Other, please specify')

  $('form').on 'change', '.unlinked_list', (event) ->
    data_type = $(this).find('option:selected').text()
    if data_type == "Please select"
      $(this).next('input[type=hidden]').val("")
      $(this).nextAll('.prompted_other').val("")
      $(this).nextAll('.prompted_other').hide()
    else if data_type == "Other, please specify"
      $(this).next('input[type=hidden]').val("")
      $(this).nextAll('.prompted_other').val("")
      $(this).nextAll('.prompted_other').show()
      $(this).nextAll('.prompted_other').focus()
    else
      $(this).next('input[type=hidden]').val(data_type)
      $(this).nextAll('.prompted_other').hide()

  $('form').on 'keyup', '.prompted_other', (event) ->
    $(this).prev('input[type=hidden]').val($(this).val())
