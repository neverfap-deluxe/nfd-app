// practices

var practices_latest_click = document.querySelector('#practices_latest_click');
var practices_latest_plain_click = document.querySelector('#practices_latest_plain_click');
var practices_category_click = document.querySelector('#practices_category_click');

var practices_latest_posts = document.querySelector('#practices_latest_posts');
var practices_latest_plain_posts = document.querySelector('#practices_latest_plain_posts');
var practices_category_posts = document.querySelector('#practices_category_posts');


practices_latest_click.onclick = function(event) {
  practices_latest_click.style.color = 'black'; 
  practices_latest_click.style.border = '5px solid black';
  practices_latest_plain_click.style.color = 'grey'; 
  practices_latest_plain_click.style.border = '5px solid grey';
  practices_category_click.style.color = 'grey'; 
  practices_category_click.style.border = '5px solid grey';

  practices_latest_posts.style.display = 'block';
  practices_latest_plain_posts.style.display = 'none';
  practices_category_posts.style.display = 'none';
};

practices_latest_plain_click.onclick = function(event) {
  practices_latest_click.style.color = 'grey'; 
  practices_latest_click.style.border = '5px solid grey';
  practices_latest_plain_click.style.color = 'black'; 
  practices_latest_plain_click.style.border = '5px solid black';
  practices_category_click.style.color = 'grey'; 
  practices_category_click.style.border = '5px solid grey';

  practices_latest_posts.style.display = 'none';
  practices_latest_plain_posts.style.display = 'block';
  practices_category_posts.style.display = 'none';
};

practices_category_click.onclick = function(event) {
  practices_latest_click.style.color = 'grey'; 
  practices_latest_click.style.border = '5px solid grey';
  practices_latest_plain_click.style.color = 'grey'; 
  practices_latest_plain_click.style.border = '5px solid grey';
  practices_category_click.style.color = 'black'; 
  practices_category_click.style.border = '5px solid black';

  practices_latest_posts.style.display = 'none';
  practices_latest_plain_posts.style.display = 'none';
  practices_category_posts.style.display = 'block';
};