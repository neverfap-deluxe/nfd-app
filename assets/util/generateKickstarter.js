const Parser = require("simple-text-parser");

const {
  generateDivider,
  generateText,
  generateTextTitle,
  generateTextTitleCentre,
  generateTextBold,
  generateButton,

  generateWrapper,
  generateFullHead,
  generate,
} = require('./templates');

const {
  getHead,
  generateEmails,
} = require('./util');

const parseFile = async () => {
  // const headParser = new Parser();
  const contentParser = new Parser();
  // const withinQuotesRegex = new RegExp(/\"[\S ]+\"/, );
  // let title;
  // let day;

  // headParser.addRule(/title: [\S ]+/ig, function(text) {
  //   title = text.split(':')[1].trim();
  //   return '';
  // });

  // headParser.addRule(/day: [\S ]+/ig, function(text) {
  //   day = text.split(':')[1].trim();
  //   return '';
  // });

  // generate text title centre
  contentParser.addRule(/{{< nfd_center_title [\S ]+ >}}/ig, function(text) {
    // TODO regex to capture everything within
    return generateTextTitleCentre(text.split('"')[1]); // withinQuotesRegex.test(text)
  });

  // generate button
  contentParser.addRule(/{{< nfd_button [\S ]+ >}}/ig, function(text) {
    return generateButton(text.split('"')[1], text.split('"')[3]);
  });

  // generate divider
  contentParser.addRule(/8{3}/ig, function(text) {
    return generateDivider(text);
  });

  // generate text bold
  contentParser.addRule(/\#\#\# [\S ]+/ig, function(text) {
    return generateTextBold(text.slice(3));
  });

  // generate text title
  contentParser.addRule(/\#\# [\S ]+/ig, function(text) {
    return generateTextTitle(text.slice(2));
  });

  // generate text
  contentParser.addRule(/[\S ]+/ig, function(text) {
    if (text.length !== 2) {
      return generateText(text);
    }
  });

  const baseUrl = 'https://neverfapdeluxe.netlify.com/md';

  for (let i = 0; i < 8; i++) {
    const kickstarterEmail = generateEmails('email_seven_day_kickstarter', `sdk-day-${i}`, `template_seven_day_kickstarter_${i}.mjml`, contentParser);

    // const baseUrl = 'http://localhost:1313/md';

    // const fileName = `${baseUrl}/email_seven_day_kickstarter/sdk-day-${i}.md`;
    // const response = await axios.get(fileName);
    // const file = response.data;
    // const { head, content } = getHead(file.toString());

    // const parsedHead = headParser.render(head);
    // const parsedContent = contentParser.render(content);

    // const headText = generateFullHead(day, title.replace(/"/g,""));
    // const contentText = generateWrapper(parsedContent)

    // const completeText = generate(headText, contentText);

    // fse.outputFileSync(`templates/email_seven_day_kickstarter/template_seven_day_kickstarter_${i}.mjml`, completeText, [{}]);

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
