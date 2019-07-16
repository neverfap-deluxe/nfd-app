var bottom__bar__container = document.querySelector('.bottom__bar__container');
var body = document.querySelector('body');

window.onscroll = function(event) {
  if (bottom__bar__container) {
    bottom__bar__container.classList.remove('bottom__bar__container__display__none');

    if (((window.innerHeight + window.scrollY) + 300) >= document.body.offsetHeight) {
      // you're at the bottom of the page
      bottom__bar__container.classList.add('bottom__bar__container__display__none')
    }  
  }
};
