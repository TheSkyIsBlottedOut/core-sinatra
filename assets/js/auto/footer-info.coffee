App.Footer =
  element: $('footer')
  populateInfo: (title, content) ->
    @element.find('h3').text(title)
    @element.find('article').html(content)
  hide: ->
    @element.animate({bottom: '-100px'}, 200)
  show: ->
    @element.animate({bottom: '0px'}, 200)
  onHover: (e) ->
    $obj = $(e.target)
    data = $obj.data()
    App.Footer.populateInfo(data.tooltipTitle, data.tooltipContent)
    App.Footer.show()
  onLeave: (e) ->
    App.Footer.hide()

$init.add '*', ->
  $('[data-tooltip-title][data-tooltip-content]').hover(App.Footer.onHover, App.Footer.onLeave)
