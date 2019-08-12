var link__home = document.querySelector('#link__home');
var link__guide = document.querySelector('#link__guide');
var link__articles = document.querySelector('#link__articles');
var link__meditation = document.querySelector('#link__meditation');
var link__podcast = document.querySelector('#link__podcast');
var link__community = document.querySelector('#link__community');
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

  case 'meditation':
    link__meditation.style.borderBottom = '5px solid orange';
    break;

  case 'podcast':
    link__podcast.style.borderBottom = '5px solid orange';
    break;

  case 'community':
    link__community.style.borderBottom = '5px solid orange';
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


// const banner__home = document.querySelector('.header__banner__home');
// const banner__guide = document.querySelector('.header__banner__guide');
// const banner__articles = document.querySelector('.header__banner__articles');
// const banner__practices = document.querySelector('.header__banner__practices');
// const banner__podcast = document.querySelector('.header__banner__podcast');
// const banner__community = document.querySelector('.header__banner__community');
// const banner__about = document.querySelector('.header__banner__about');

// const linkList = [link__home, link__guide, link__articles, link__meditation, link__podcast, link__community, link__about];
// const bannerList = [banner__home, banner__guide, banner__articles, banner__practices, banner__podcast, banner__community, banner__about];

// let isLinkHover = false;
// let isBannerHover = false;


// linkList.forEach(link => {
//   link.addEventListener('onmouseout', function () {
//     if (isLinkHover) {
//       isLinkHover = false;
//     } else {
//       isLinkHover = true;
//     }

//     if (isLinkHover || isBannerHover) {
//       link.style.display = "block";
//     } else {
//       link.style.display = "none";
//     }
//   });
// });

// bannerList.forEach(banner => {
//   banner.addEventListener('onmouseout', function () {
//     if (isBannerHover) {
//       isBannerHover = false;
//     } else {
//       isBannerHover = true;
//     }

//     if (isLinkHover || isBannerHover) {
//       banner.style.display = "block";
//     } else {
//       banner.style.display = "none";
//     }
//   });
// });

