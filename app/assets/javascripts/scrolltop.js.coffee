ready = ->
  console.log("[TRACE] ready now")
  $(window).scroll ->
    console.log("[TRACE] Scroll event ignited")
    element = $('#page-top-btn')
    visible = element.is(':visible')
    height = $(window).scrollTop()
    if height > 200
      element.fadeIn() if !visible
    else
      element.fadeOut()
  $(document).on 'click', '#page-top-btn', ->
    console.log("[DEBUG] click Ignited")
    $('html, body').animate({ scrollTop: 0 }, 'slow')

$(document).ready(ready)
$(document).on('page:load', ready)
