$(document).on 'ready page:change', ->
  $("#list_values").sortable
    cursor: "move"
    update: (event, ui) ->
      $("input.sort").each (index) ->
        $(this).val index + 1
