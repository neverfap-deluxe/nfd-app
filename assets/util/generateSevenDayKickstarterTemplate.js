const fse = require('fs-extra');
const Parser = require("simple-text-parser");
const parser = new Parser();

const generateHead = (dayNumber) => `
  <mj-head>
    <mj-title>NeverFap Deluxe Seven Day Kickstarter | Day ${dayNumber}</mj-title>
    <mj-preview>NeverFap Deluxe Seven Day Kickstarter Preview</mj-preview>
    <mj-attributes>
      <mj-all font-family="'Helvetica Neue', Helvetica, Arial, sans-serif"></mj-all>
      <mj-text font-weight="400" font-size="16px" color="#000000" line-height="24px" font-family="'Helvetica Neue', Helvetica, Arial, sans-serif"></mj-text>
    </mj-attributes>
    <mj-style inline="inline">
      .body-section { -webkit-box-shadow: 1px 4px 11px 0px rgba(0, 0, 0, 0.15); -moz-box-shadow: 1px 4px 11px 0px rgba(0, 0, 0, 0.15); box-shadow: 1px 4px 11px 0px rgba(0, 0, 0, 0.15); }
    </mj-style>
  </mj-head>
`;

const generateSection = (dayNumber, title) => `
  <mj-section full-width="full-width" background-color="linear-gradient(45deg, rgba(255,46,182,1) 0%, rgba(227,152,2,1) 100%)" padding-bottom="0">
    <mj-column width="100%">
      <mj-text color="#ffffff" font-weight="bold" align="center" text-transform="uppercase" font-size="16px" letter-spacing="1px" padding-top="30px">
        NeverFap Deluxe
        <br/>
        <span style="color: #979797; font-weight: normal">-</span>
      </mj-text>
      <mj-text color="white" align="center" font-size="13px" padding-top="0" font-weight="bold" text-transform="uppercase" letter-spacing="1px" line-height="20px">
        Day ${dayNumber}
        <br/> ${title}
      </mj-text>

      <mj-image src="https://f002.backblazeb2.com/file/neverfapdeluxeemail/email__header.png" width="600px" alt="" padding="0" href="https://neverfapdeluxe.com" />
    </mj-column>
  </mj-section>
`;

const generateWrapper = (content) => `
  <mj-wrapper padding-top="0" padding-bottom="0" css-class="body-section">
    <mj-section background-color="#ffffff" padding-left="15px" padding-right="15px">
      <mj-column width="100%">

        ${content}

        <!-- Divider -->
        <mj-text color="#35393d" font-size="16px"></mj-text>
        <mj-divider border-color="#DFE3E8" border-width="1px" />
        <mj-text color="#35393d" font-size="16px"></mj-text>
        <!-- Divider -->

        <mj-image src="https://f002.backblazeb2.com/file/neverfapdeluxeemail/email__header__assort.png" alt="" />

      </mj-column>
    </mj-section>
  </mj-wrapper>
`;

const generateDivider = () => `
  <!-- Divider -->
  <mj-text color="#35393d" font-size="16px"></mj-text>
  <mj-divider border-color="#DFE3E8" border-width="1px" />
  <mj-text color="#35393d" font-size="16px"></mj-text>
  <!-- Divider -->
`;

const generateText = (text) => `
  <mj-text color="#35393d" font-size="16px">
    ${text}
  </mj-text>
`;

const generateTextTitle = (text) => `
  <mj-text color="#212b35" font-weight="bold" font-size="20px">
    ${text}
  </mj-text>
`;

const generateTextTitleCentre = (text) => `
  <mj-text color="#35393d" font-size="16px" padding-top="20px" align="center">
  <strong>${text}</strong>
  </mj-text>
`;

const generateTextBold = (text) => `
  <mj-text color="#35393d" font-size="20px" line-height="30px">
    <strong>${text}</strong>
  </mj-text>
`;

const generateButton = (link, text) => `
  <mj-button padding-top="0px" background-color="white" color="black" border="4px solid #00ffee;" href="${link}">
    ${text}
  </mj-button>
`;

const generate = (content, day, title) => `
  <mjml>
    ${generateHead(day)}
    <mj-body background-color="#E7E7E7" width="600px">
      ${generateSection(day, title)}
      ${generateWrapper(content)}
      <mj-include path="../email_partials/seven_day_bottom.mjml"/>
    </mj-body>
  </mlmj>
`;

const parseFile = () => {
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
  parser.addRule(/nfd_center_title [\S ]+/ig, function(text) {
    // TODO regex to capture everything within
    return generateTextTitleCentre(withinQuotesRegex.test(text));
  });

  // generate button
  parser.addRule(/nfd_button [\S ]+/ig, function(text) {
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

  // seven day kickstarter
  for (let i = 0; i < 8; i++) {
    const fileName = `template_seven_day_kickstarter_${i}`;
    const file = fse.readFileSync(`templates/email_seven_day_kickstarter_md/${fileName}.md`, [{}]);

    const parsedFile = parser.render(file.toString());
    const parsedContent = generate(parsedFile, day, title)

    fse.outputFileSync(`templates/email_seven_day_kickstarter/${fileName}.mjml`, parsedContent, [{}]);
  }
};

parseFile();
