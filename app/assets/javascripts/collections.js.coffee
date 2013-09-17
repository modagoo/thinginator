$(document).on 'ready page:change', ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.remove_fields', (event) ->
    if $(this).hasClass("property-warning")
      if confirm("If you delete this property it will delete all of it's existing data, you might be safer just to 'hide' it, are you sure you want to delete it and all it's data?")
        $(this).prev("input[type=hidden]").val("1");
        $(this).closest("fieldset.property").hide();
    else
      $(this).prev("input[type=hidden]").val("1");
      $(this).closest("fieldset.property").hide();
    event.preventDefault()
