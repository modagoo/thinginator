$(document).on 'ready page:change', ->

  $('form').on 'change', 'input', (event) ->
    $(".changed").fadeIn()

  $('div.field_with_errors').closest('div.collapse').each () ->
    $(this).removeClass('collapse').addClass('in')
    $(this).prev($('*[data-collapse]')).text('hide')

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $(this).prev().find($('div.collapse')).removeClass('collapse').addClass('in')
    $(this).prev().find($('*[data-collapse]')).text('hide')
    $(".changed").fadeIn()
    event.preventDefault()

  $('form').on 'change', '.data_type_select', (event) ->
    data_type = $(this).find('option:selected').text()
    if data_type == "List"
      if $(this).parent().next('.list-fields').length > 0
        $(this).parent().next('.list-fields').show()
        $(this).parent().next('.list-fields').children('.list-fields-multi').show()
        $(this).parent().next(".list-fields input[type=hidden]:first-of-type").val(false)
      else
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).closest(".field").after($(this).data('fields').replace(regexp, time))
    else if data_type == "List prompted text"
      if $(this).parent().next('.list-fields').length > 0
        $(this).parent().next('.list-fields').show()
        $(this).parent().next('.list-fields').children('.list-fields-multi').hide()
        $(this).parent().next(".list-fields input[type=hidden]:first-of-type").val(false)
      else
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).closest(".field").after($(this).data('fields').replace(regexp, time))
        $(this).parent().next('.list-fields').children('.list-fields-multi').hide()
    else
      $(this).parent().next(".list-fields input[type=hidden]:first-of-type").val("1")
      $(this).parent().next(".list-fields").hide()
      $(this).parent().next('.list-fields').children('.list-fields-multi').hide()
    event.preventDefault()

  $('form').on 'click', '.remove_fields', (event) ->
    if $(this).hasClass("property-warning")
      if confirm("If you delete this property it will delete all of it's existing data, you might be safer just to 'hide' it, are you sure you want to delete it and all it's data?")
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest("fieldset.property").hide();
    else
      $(this).prev("input[type=hidden]").val("1");
      $(this).closest("fieldset.property").hide();
    $(".changed").fadeIn()
    event.preventDefault()

  $ ->
    $(".datepicker").datetimepicker pickTime: false, language: "EN"
    $(".timepicker").datetimepicker pickDate: false, language: "EN", pickSeconds: false
    $(".datetimepicker").datetimepicker language: "EN"

  $("#properties").sortable
    cursor: "move"
    update: (event, ui) ->
      $("input.sort").each (index) ->
        $(this).val index + 1
      $(".changed").fadeIn()

  $('form').on 'click', '*[data-collapse]', (e) =>
    if $(e.target).next().hasClass("collapse")
      $(e.target).next().slideDown('fast')
      $(e.target).next().removeClass("collapse")
      $(e.target).next().addClass("in")
      $(e.target).text("hide")
    else if $(e.target).next().hasClass("in")
      $(e.target).next().slideUp('fast')
      $(e.target).next().removeClass("in")
      $(e.target).next().addClass("collapse")
      $(e.target).text("show")
    e.preventDefault()
