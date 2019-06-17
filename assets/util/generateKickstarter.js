const fse = require('fs-extra');
const axios = require('axios');
const Parser = require("simple-text-parser");

const {
  generateHead,
  generateSection,
  generateWrapper,
  generateDivider,
  generateText,
  generateTextTitle,
  generateTextTitleCentre,
  generateTextBold,
  generateButton,
  generate,
} = require('./templates');

const {
  getHead
} = require('./util');

const parseFile = async () => {
  const parser = new Parser();
  const withinQuotesRegex = new RegExp(/\"[\S ]+\"/, );
  let title;
  let day;

  parser.addRule(/title: [\S ]+/ig, function(text) {
    title = text.split(':')[1].trim();
    return '';
  });

  parser.addRule(/day: [\S ]+/ig, function(text) {
    day = text.split(':')[1].trim();
    return '';
  });

  // generate text title centre
  parser.addRule(/{{< nfd_center_title [\S ]+ >}}/ig, function(text) {
    // TODO regex to capture everything within
    return generateTextTitleCentre(withinQuotesRegex.test(text));
  });

  // generate button
  parser.addRule(/{{< nfd_button [\S ]+ >}}/ig, function(text) {
    return generateButton(text, withinQuotesRegex.test(text));
  });

  // generate divider
  parser.addRule(/-{3}/ig, function(text) {
    return generateDivider(text);
  });

  // generate text bold
  parser.addRule(/\#\#\# [\S ]+/ig, function(text) {
    return generateTextBold(text.slice(3));
  });

  // generate text title
  parser.addRule(/\#\# [\S ]+/ig, function(text) {
    return generateTextTitle(text.slice(2));
  });

  // generate text
  parser.addRule(/[\S ]+/ig, function(text) {
    if (text.length !== 2) {
      return generateText(text);
    }
  });

  for (let i = 0; i < 8; i++) {
    const baseUrl = 'https://neverfapdeluxe.netlify.com/md';
    // const baseUrl = 'http://localhost:1313/md';

    const fileName = `${baseUrl}/email_seven_day_kickstarter/sdk-day-${i}.md`;
    const response = await axios.get(fileName);
    const file = response.data;
    const { head, content } = getHead(file.toString());
    const parsedFile = parser.render(content);
    const parsedContent = generate(parsedFile, day, title)

    fse.outputFileSync(`templates/email_seven_day_kickstarter/template_seven_day_kickstarter_${i}.mjml`, parsedContent, [{}]);
  }
};

parseFile();


// for (let i = 0; i < 8; i++) {
//   const fileName = `template_seven_day_kickstarter_${i}`;
//   const file = fse.readFileSync(`templates/email_seven_day_kickstarter_md/${fileName}.md`, [{}]);

//   const parsedFile = parser.render(file.toString());
//   const parsedContent = generate(parsedFile, day, title)

//   fse.outputFileSync(`templates/email_seven_day_kickstarter/${fileName}.mjml`, parsedContent, [{}]);
// }
