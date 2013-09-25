$(document).on 'ready page:change', ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'change', '.data_type_select', (event) ->
    data_type = $(this).find('option:selected').text()
    if data_type == "List"
      console.log("show fields")
      if $(this).parent().find('.list-fields').length > 0
        $('.list-fields').show()
        $(".list-fields input[type=hidden]:first-of-type").val(false)
      else
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).closest(".field").after($(this).data('fields').replace(regexp, time))
    else
      console.log("hide fields")
      $(".list-fields input[type=hidden]:first-of-type").val("1")
      $(".list-fields").hide()
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

  $ ->
    $(".datepicker").datetimepicker pickTime: false, language: "EN"
    $(".timepicker").datetimepicker pickDate: false, language: "EN"
    $(".datetimepicker").datetimepicker language: "EN"




