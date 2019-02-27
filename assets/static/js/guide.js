
// guide post categories

var introduction_click = document.querySelector('#introduction_click');
var choice_over_mind_click = document.querySelector('#choice_over_mind_click');
var balance_over_reward_click = document.querySelector('#balance_over_reward_click');
var struggle_over_none_click = document.querySelector('#struggle_over_none_click');
var awareness_over_all_click = document.querySelector('#awareness_over_all_click');
var uncondition_over_judgement_click = document.querySelector('#uncondition_over_judgement_click');

var introduction_posts = document.querySelector('#introduction_posts');
var choice_over_mind_posts = document.querySelector('#choice_over_mind_posts');
var balance_over_reward_posts = document.querySelector('#balance_over_reward_posts');
var strugle_over_none_posts = document.querySelector('#strugle_over_none_posts');
var awareness_over_all_posts = document.querySelector('#awareness_over_all_posts');
var uncondition_over_judgement_posts = document.querySelector('#uncondition_over_judgement_posts');

introduction_click.onclick = function(event) {
  introduction_click.style.color = 'black'; 
  introduction_click.style.border = '5px solid black';
  choice_over_mind_click.style.color = 'grey'; 
  choice_over_mind_click.style.border = '5px solid grey';
  balance_over_reward_click.style.color = 'grey'; 
  balance_over_reward_click.style.border = '5px solid grey';
  struggle_over_none_click.style.color = 'grey'; 
  struggle_over_none_click.style.border = '5px solid grey';
  awareness_over_all_click.style.color = 'grey'; 
  awareness_over_all_click.style.border = '5px solid grey';
  uncondition_over_judgement_click.style.color = 'grey'; 
  uncondition_over_judgement_click.style.border = '5px solid grey';

  introduction_posts.style.display = 'block';
  choice_over_mind_posts.style.display = 'none';
  balance_over_reward_posts.style.display = 'none';
  strugle_over_none_posts.style.display = 'none';
  awareness_over_all_posts.style.display = 'none';
  uncondition_over_judgement_posts.style.display = 'none';
};

choice_over_mind_click.onclick = function(event) {
  console.log('yo')
  introduction_click.style.color = 'grey'; 
  introduction_click.style.border = '5px solid grey';
  choice_over_mind_click.style.color = 'black'; 
  choice_over_mind_click.style.border = '5px solid black';
  balance_over_reward_click.style.color = 'grey'; 
  balance_over_reward_click.style.border = '5px solid grey';
  struggle_over_none_click.style.color = 'grey'; 
  struggle_over_none_click.style.border = '5px solid grey';
  awareness_over_all_click.style.color = 'grey'; 
  awareness_over_all_click.style.border = '5px solid grey';
  uncondition_over_judgement_click.style.color = 'grey'; 
  uncondition_over_judgement_click.style.border = '5px solid grey';

  introduction_posts.style.display = 'none';
  choice_over_mind_posts.style.display = 'block';
  balance_over_reward_posts.style.display = 'none';
  strugle_over_none_posts.style.display = 'none';
  awareness_over_all_posts.style.display = 'none';
  uncondition_over_judgement_posts.style.display = 'none';
};

balance_over_reward_click.onclick = function(event) {
  introduction_click.style.color = 'grey'; 
  introduction_click.style.border = '5px solid grey';
  choice_over_mind_click.style.color = 'grey'; 
  choice_over_mind_click.style.border = '5px solid grey';
  balance_over_reward_click.style.color = 'black'; 
  balance_over_reward_click.style.border = '5px solid black';
  struggle_over_none_click.style.color = 'grey'; 
  struggle_over_none_click.style.border = '5px solid grey';
  awareness_over_all_click.style.color = 'grey'; 
  awareness_over_all_click.style.border = '5px solid grey';
  uncondition_over_judgement_click.style.color = 'grey'; 
  uncondition_over_judgement_click.style.border = '5px solid grey';

  introduction_posts.style.display = 'none';
  choice_over_mind_posts.style.display = 'none';
  balance_over_reward_posts.style.display = 'block';
  strugle_over_none_posts.style.display = 'none';
  awareness_over_all_posts.style.display = 'none';
  uncondition_over_judgement_posts.style.display = 'none';
};

struggle_over_none_click.onclick = function(event) {
  introduction_click.style.color = 'grey'; 
  introduction_click.style.border = '5px solid grey';
  choice_over_mind_click.style.color = 'grey'; 
  choice_over_mind_click.style.border = '5px solid grey';
  balance_over_reward_click.style.color = 'grey'; 
  balance_over_reward_click.style.border = '5px solid grey';
  struggle_over_none_click.style.color = 'black'; 
  struggle_over_none_click.style.border = '5px solid black';
  awareness_over_all_click.style.color = 'grey'; 
  awareness_over_all_click.style.border = '5px solid grey';
  uncondition_over_judgement_click.style.color = 'grey'; 
  uncondition_over_judgement_click.style.border = '5px solid grey';

  introduction_posts.style.display = 'none';
  choice_over_mind_posts.style.display = 'none';
  balance_over_reward_posts.style.display = 'none';
  strugle_over_none_posts.style.display = 'block';
  awareness_over_all_posts.style.display = 'none';
  uncondition_over_judgement_posts.style.display = 'none';
};

awareness_over_all_click.onclick = function(event) {
  introduction_click.style.color = 'grey'; 
  introduction_click.style.border = '5px solid grey';
  choice_over_mind_click.style.color = 'grey'; 
  choice_over_mind_click.style.border = '5px solid grey';
  balance_over_reward_click.style.color = 'grey'; 
  balance_over_reward_click.style.border = '5px solid grey';
  struggle_over_none_click.style.color = 'grey'; 
  struggle_over_none_click.style.border = '5px solid grey';
  awareness_over_all_click.style.color = 'black'; 
  awareness_over_all_click.style.border = '5px solid black';
  uncondition_over_judgement_click.style.color = 'grey'; 
  uncondition_over_judgement_click.style.border = '5px solid grey';

  introduction_posts.style.display = 'none';
  choice_over_mind_posts.style.display = 'none';
  balance_over_reward_posts.style.display = 'none';
  strugle_over_none_posts.style.display = 'none';
  awareness_over_all_posts.style.display = 'block';
  uncondition_over_judgement_posts.style.display = 'none';
};

uncondition_over_judgement_click.onclick = function(event) {
  introduction_click.style.color = 'grey'; 
  introduction_click.style.border = '5px solid grey';
  choice_over_mind_click.style.color = 'grey'; 
  choice_over_mind_click.style.border = '5px solid grey';
  balance_over_reward_click.style.color = 'grey'; 
  balance_over_reward_click.style.border = '5px solid grey';
  struggle_over_none_click.style.color = 'grey'; 
  struggle_over_none_click.style.border = '5px solid grey';
  awareness_over_all_click.style.color = 'grey'; 
  awareness_over_all_click.style.border = '5px solid grey';
  uncondition_over_judgement_click.style.color = 'black'; 
  uncondition_over_judgement_click.style.border = '5px solid black';

  introduction_posts.style.display = 'none';
  choice_over_mind_posts.style.display = 'none';
  balance_over_reward_posts.style.display = 'none';
  strugle_over_none_posts.style.display = 'none';
  awareness_over_all_posts.style.display = 'none';
  uncondition_over_judgement_posts.style.display = 'block';
};
