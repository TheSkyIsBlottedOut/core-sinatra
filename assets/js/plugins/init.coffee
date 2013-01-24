###
 $init.add('controller', function() {});
 $init.add('controller-action', function() {});
###

# dynamics for hooking up controller / page-specific code based on
# html element class list
window.$init =
  callbacks: {} # className: [func, ...]

  # register fn to run at DOMContentLoaded time on `className` pages
  add: (className, fn) ->
    $.makeArray(className).forEach (className) =>
      if typeof fn isnt 'function'
        throw new TypeError("$init.add: not a function: #{fn}")
      (@callbacks[className] ||= []).push fn
    undefined

  # runs all functions registered for className now
  call: (className) ->
    me        = "$init.call('#{className}')"
    callbacks = @callbacks[className] || []
    fn()  for fn in callbacks
    # else
    #   # FIXME: log production js exceptions somewhere for QA purposes?
    #   (try fn() catch e then console.error me, e)  for fn in callbacks
    undefined

  # run all functions registered for the class names of page element `selector`
  execute: (selector) ->
    $elem = $(selector)
    for className of @callbacks
      $init.call className  if $elem.hasClass className

$(document).ready ->
  $init.execute 'html'
  $init.call '*'
