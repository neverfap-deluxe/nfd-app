
// articles

var articles_latest_click = document.querySelector('#articles_latest_click');
var articles_latest_plain_click = document.querySelector('#articles_latest_plain_click');
var articles_category_click = document.querySelector('#articles_category_click');

var articles_latest_posts = document.querySelector('#articles_latest_posts');
var articles_latest_plain_posts = document.querySelector('#articles_latest_plain_posts');
var articles_category_posts = document.querySelector('#articles_category_posts');

articles_latest_click.onclick = function(event) {
  articles_latest_click.style.color = 'black'; 
  articles_latest_click.style.border = '5px solid black';
  articles_latest_plain_click.style.color = 'grey'; 
  articles_latest_plain_click.style.border = '5px solid grey';
  articles_category_click.style.color = 'grey'; 
  articles_category_click.style.border = '5px solid grey';

  articles_latest_posts.style.display = 'block';
  articles_latest_plain_posts.style.display = 'none';
  articles_category_posts.style.display = 'none';
};


articles_latest_plain_click.onclick = function(event) {
  articles_latest_click.style.color = 'grey'; 
  articles_latest_click.style.border = '5px solid grey';
  articles_latest_plain_click.style.color = 'black'; 
  articles_latest_plain_click.style.border = '5px solid black';
  articles_category_click.style.color = 'grey'; 
  articles_category_click.style.border = '5px solid grey';

  articles_latest_posts.style.display = 'none';
  articles_latest_plain_posts.style.display = 'block';
  articles_category_posts.style.display = 'none';
};

articles_category_click.onclick = function(event) {
  articles_latest_click.style.color = 'grey'; 
  articles_latest_click.style.border = '5px solid grey';
  articles_latest_plain_click.style.color = 'grey'; 
  articles_latest_plain_click.style.border = '5px solid grey';
  articles_category_click.style.color = 'black'; 
  articles_category_click.style.border = '5px solid black';

  articles_latest_posts.style.display = 'none';
  articles_latest_plain_posts.style.display = 'none';
  articles_category_posts.style.display = 'block';
};