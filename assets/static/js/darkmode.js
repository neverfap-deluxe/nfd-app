var dark__mode__button = document.querySelector('#dark__mode__button');
var footer = document.querySelector('#footer');
var bottom_bar = document.querySelector('#bottom_bar');
var cookies__popup = document.querySelector('#cookies__popup');
var general__main__content = document.querySelector('#general__main__content');
var dark__mode__on = false;

var isDarkMode = 'isDarkMode';

if (getCookie(isDarkMode) === 'true') {
  setDarkMode();
}

dark__mode__button.onclick = function(event) {
  if (dark__mode__on) {
    unsetDarkMode();
  } else {
    setDarkMode();
  }
}

function unsetDarkMode() {
  dark__mode__on = false;
  general__main__content.classList.remove('main__dark');
  footer.classList.remove('main__dark');
  cookies__popup.classList.remove('main__dark');
  bottom_bar.classList.remove('main__dark');

  dark__mode__button.classList.remove('dark__mode__button__hovered');
  setCookie(isDarkMode, 'false', 90);
}

function setDarkMode() {
  dark__mode__on = true;
  general__main__content.classList.add('main__dark');
  footer.classList.add('main__dark');
  cookies__popup.classList.add('main__dark');
  bottom_bar.classList.add('main__dark');

  dark__mode__button.classList.add('dark__mode__button__hovered');
  setCookie(isDarkMode, 'true', 90);
}

function setCookie(name,value,days) {
  var expires = "";
  if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days*24*60*60*1000));
      expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}

function getCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1,c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

function eraseCookie(name) {   
  document.cookie = name+'=; Max-Age=-99999999;';  
}
