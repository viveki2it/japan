$(document).on 'ready', ()->
  initializeLightBox('.gallery li a')

initializeLightBox = (selector) ->
  $(selector).lightBox(
    fixedNavigation: true
    imageBlank: '/assets/lightbox-blank.gif'
    imageLoading: '/assets/lightbox-ico-loading.gif'
    imageBtnClose: '/assets/lightbox-btn-close.gif'
    imageBtnPrev: '/assets/lightbox-btn-prev.gif'
    imageBtnNext: '/assets/lightbox-btn-next.gif')