
var cookies__popup__container__id = document.querySelector('#cookies__popup__container__id');
var acceptedCookie = 'acceptedCookie';

if (getCookie(acceptedCookie) !== 'true') {
  cookies__popup__container__id.classList.remove('none');
  cookies__popup__container__id.classList.add('cookies__popup__container');
}

cookies__read__more.onclick = function(event) {
  var cookies__read__more = document.querySelector('#cookies__read__more');
  var cookies__close = document.querySelector('#cookies__close');
  setCookie(acceptedCookie, 'true', 900);
  cookies__popup__container__id.style.display = 'none';
}

cookies__close.onclick = function(event) {
  var cookies__read__more = document.querySelector('#cookies__read__more');
  var cookies__close = document.querySelector('#cookies__close');
  setCookie(acceptedCookie, 'true', 900);
  cookies__popup__container__id.style.display = 'none';
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
