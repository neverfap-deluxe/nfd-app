const TurndownService = require('turndown')
const turndownService = new TurndownService()

const getHead = (fileContents) => {
  const headRegex = new RegExp(/---(.|[\r\n])+---/);
  const head = fileContents.match(headRegex)[0];

  const rawWithHTMLContent = fileContents.split('---')[2];
  // const rawWithMDContent = turndownService.turndown(rawWithHTMLContent);
  // const content = filterContent(rawWithMDContent);

  return {
    head,
    content: rawWithHTMLContent,
  }  
}

module.exports = {
  getHead,
}