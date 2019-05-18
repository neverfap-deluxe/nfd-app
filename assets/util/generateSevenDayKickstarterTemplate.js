const fse = require('fs-extra');

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

const generateWrapper = () => `
  <mj-wrapper padding-top="0" padding-bottom="0" css-class="body-section">
    <mj-section background-color="#ffffff" padding-left="15px" padding-right="15px">
      <mj-column width="100%">

        ${parseFile()}

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

const generateTextBold = (text) => `
  <mj-text color="#35393d" font-size="20px" line-height="30px">
    <strong>${text}</strong>
  </mj-text>
`;

const generateButton = () => `

`;

const generate = () => `
  <mjml>
    ${generateHead(0)}
    <mj-body background-color="#E7E7E7" width="600px">
      ${generateSection(0, "The beginning")}
      ${generateWrapper()}
      <mj-include path="../email_partials/seven_day_bottom.mjml"/>
    </mj-body>  
  </mlmj>
`;

const parseFile = (fileName) => {
  // maybe I just need a
  // text parser utili

  // seven day kickstarter
  for (let i = 0; i < 8; i++) {
    const fileName = `template_seven_day_kickstarter_${i}.mjml`;
    const file = fse.readFileSync(`src/${fileName}`, itemsComplete, [{}]);

    // do parsing stuff.
    generateDivider
    generateText
    generateTextTitle
    generateTextBold
    generateButton
  }
};
