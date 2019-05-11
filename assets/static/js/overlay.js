var overlay = document.querySelector('#mobile__menu__overlay__id');
var overlay__background = document.querySelector('#mobile__menu__overlay__background__id');

var overlay__button = document.querySelector('#mobile__menu__overlay__button__id');
var overlay__button__close = document.querySelector('#mobile__overlay__close__id');

var overlayState = false;

overlay__button__close.onclick = function(event) {
  overlayState = false;
  overlay.style.display = 'none';
  overlay__background.style.display = 'none';
}

overlay__button.onclick = function(event) {
  overlayState = true;
  overlay.style.display = 'block';
  overlay__background.style.display = 'block';
}