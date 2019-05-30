var overlay = document.querySelector('#mobile__menu__overlay__id');
var overlay__background = document.querySelector('#mobile__menu__overlay__background__id');
// var overlay__background__colour = document.querySelector('.everything__container__outer');
// var overlay__within = document.querySelector('.overlay__within');

var overlay__button = document.querySelector('#mobile__menu__overlay__button__id');
var overlay__button__close = document.querySelector('#mobile__overlay__close__id');

var overlayState = false;

// TODO: Add escape key for this thing.
// addEventListener('', function(event) {

// });

window.addEventListener("keydown", function (event) {
  if (event.defaultPrevented) {
    return; // Do nothing if the event was already processed
  }

  switch (event.key) {
    case "Escape":
      overlayState = false;
      overlay.style.display = 'none';
      overlay__background.style.display = 'none';
      break;
    default:
      return; // Quit when this doesn't handle the key event.
  }
  // Cancel the default action to avoid it being handled twice
  event.preventDefault();
}, true);


overlay__button__close.onclick = function(event) {
  overlayState = false;
  overlay.style.display = 'none';
  overlay__background.style.display = 'none';
  // overlay__background__colour.style.background = 'initial';
}

overlay__button.onclick = function(event) {
  overlayState = true;
  overlay.style.display = 'block';
  overlay__background.style.display = 'block';
  // overlay__background__colour.style.background = 'lightgrey';
}