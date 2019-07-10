// const TurndownService = require('turndown')
// const turndownService = new TurndownService()

const fse = require('fs-extra');
const axios = require('axios');

const {
  generateWrapper,
  generateFullHead,
  generate,
} = require('./templates');

const getHead = (fileContents, type) => {
  const headRegex = new RegExp(/---(.|[\r\n])+---/);
  const head = fileContents.match(headRegex)[0];

  const rawWithHTMLContent = fileContents.split('---')[2];

  if (type === 'kickstarter') {
    return {
      head,
      content: rawWithHTMLContent,
    }  
  }

  if (type === 'awareness' || type === 'meditation') {
    return {
      head,
      content: rawWithHTMLContent.split('## Script')[0],
    }  
  }
  // const rawWithMDContent = turndownService.turndown(rawWithHTMLContent);
  // const content = filterContent(rawWithMDContent);
}

const generateEmails = async (type, collection, item, template_item, contentParser) => {
  try {
    const baseUrl = 'https://neverfapdeluxe.netlify.com/md';
    // const baseUrl = 'http://localhost:1313/md';

    const fileName = `${baseUrl}/${collection}/${item}.md`;
    const response = await axios.get(fileName);
    const file = response.data;

    const { head, content } = getHead(file.toString(), type);

    const getHeadTitleRegex = /title: [\S ]+/ig
    const getHeadDayRegex = /day: [\S ]+/ig

    const title = head.match(getHeadTitleRegex)[0].split(':')[1].trim();
    const day = head.match(getHeadDayRegex)[0].split(':')[1].trim();

    const parsedContent = contentParser.render(content);

    const headText = generateFullHead(day, title.replace(/"/g, ""));
    const contentText = generateWrapper(parsedContent)

    const completeText = generate(headText, contentText);

    fse.outputFileSync(`templates/${collection}/${template_item}`, completeText, [{}]);
  } catch (error) {
    console.log(fileName);
    throw new Error(`${error} - ${fileName}`);
  }
}

module.exports = {
  getHead,
  generateEmails,
}