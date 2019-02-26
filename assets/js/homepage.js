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
