const {
  generateTextTitleCentre,
  generateButton,
  generateDivider,
  generateTextBold,
  generateTextTitle,
  generateText,
} = require("./templates");

const generateContentParser = (parser) => {
  // generate text title centre
  parser.addRule(/{{< nfd_center_title [\S ]+ >}}/ig, function (text) {
    // TODO regex to capture everything within
    return generateTextTitleCentre(text.split('"')[1]); // withinQuotesRegex.test(text)
  });

  // generate button
  parser.addRule(/{{< nfd_button [\S ]+ >}}/ig, function (text) {
    return generateButton(text.split('"')[1], text.split('"')[3]);
  });

  // generate divider
  parser.addRule(/8{3}/ig, function (text) {
    return generateDivider(text);
  });

  // generate text bold
  parser.addRule(/\#\#\# [\S ]+/ig, function (text) {
    return generateTextBold(text.slice(3));
  });

  // generate text title
  parser.addRule(/\#\# [\S ]+/ig, function (text) {
    return generateTextTitle(text.slice(2));
  });

  // generate text
  parser.addRule(/[\S ]+/ig, function (text) {
    if (text.length !== 2) {
      return generateText(text);
    }
  });

  return parser;
}

module.exports = {
  generateContentParser,
}