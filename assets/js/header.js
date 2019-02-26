var link__home = document.querySelector('#link__home');
var link__guide = document.querySelector('#link__guide');
var link__articles = document.querySelector('#link__articles');
var link__practices = document.querySelector('#link__practices');
var link__courses = document.querySelector('#link__courses');
var link__about = document.querySelector('#link__about');

var pathname = window.location.pathname; // usually it's /article/
var splitPath = pathname.split('/');
var pathnameProper = splitPath[1];

switch(pathnameProper) {
  case '':
    link__home.style.borderBottom = '5px solid orange';
    break;

  case 'guide':
    link__guide.style.borderBottom = '5px solid orange';
    break;

  case 'articles':
    link__articles.style.borderBottom = '5px solid orange';
    break;
  
  case 'practices':
    link__practices.style.borderBottom = '5px solid orange';
    break;

  case 'courses':
    link__courses.style.borderBottom = '5px solid orange';
    break;

  case 'about':
    link__about.style.borderBottom = '5px solid orange';
    break;
}

// var good_choice = document.querySelector('.header__link__wrapper--guide--good-choice');

// if (pathnameProper === 'guide') {
//   good_choice.style.display = 'block';
// } else {
//   good_choice.style.display = 'none';
// }


var isClicked = false;
var articles__click = document.querySelector('#articles__click');
var articles__dropdown = document.querySelector('#articles__dropdown');
articles__click.onmouseover = function(event) { 
  if (isClicked) {
    articles__dropdown.style.display = 'none';
    isClicked = false;
  } else {
    articles__dropdown.style.display = 'block';
    isClicked = true;
  }
} 

// articles__click.onmouseoff = function(event) { 
//   if (isClicked) {
//     articles__dropdown.style.display = 'block';
//     isClicked = false;
//   } else {
//     articles__dropdown.style.display = 'none';
//     isClicked = true;
//   }
// } 