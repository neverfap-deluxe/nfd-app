// index.html

var latest__post__click = document.querySelector('#latest');
var latest__posts = document.querySelector('#latest__posts');

var popular__post__click = document.querySelector('#popular');
var popular__posts = document.querySelector('#popular__posts');

latest__post__click.onclick = function(event) { 
  latest__post__click.style.color = 'black';
  latest__post__click.style.border = '5px solid black';
  popular__post__click.style.color = 'grey';
  popular__post__click.style.border = '5px solid grey';
  
  latest__posts.style.display = 'block';
  popular__posts.style.display = 'none';
}
popular__post__click.onclick = function(event) { 
  latest__post__click.style.color = 'grey';
  latest__post__click.style.border = '5px solid grey';
  popular__post__click.style.color = 'black';
  popular__post__click.style.border = '5px solid black';

  latest__posts.style.display = 'none';
  popular__posts.style.display = 'block';
} 


// THIS IS FOR THE SPLIT VIEW FUNCTIONALITY
// var new__neverfapper = document.querySelector('#new-neverfapper');
// var new__neverfapper__body = document.querySelector('#new-neverfapper-body');

// var veteran__neverfapper = document.querySelector('#veteran-neverfapper');
// var veteran__neverfapper__body = document.querySelector('#veteran-neverfapper-body');

// new__neverfapper.onclick = function(event) { 
//   new__neverfapper__body.style.left = '0';
//   veteran__neverfapper__body.style.left = '100vw';

//   new__neverfapper__body.style.display = 'block';
//   veteran__neverfapper__body.style.display = 'none';
// }

// veteran__neverfapper.onclick = function(event) { 
//   new__neverfapper__body.style.left = '100vw';
//   veteran__neverfapper__body.style.left = '0';

//   new__neverfapper__body.style.display = 'none';
//   veteran__neverfapper__body.style.display = 'block';
// }

