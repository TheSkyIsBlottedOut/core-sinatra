$init.add 'phase-worker-placement', ->

  $('.button.add-units').click (e) ->
    $building = $(this).parents('.building')
    $building.find('.occupants .unit:not(.occupied)').first().addClass('occupied')

  $('.button.subtract-units').click (e) ->
    $building = $(this).parents('.building')
    $building.find('.occupants .unit.occupied').last().removeClass('occupied')
