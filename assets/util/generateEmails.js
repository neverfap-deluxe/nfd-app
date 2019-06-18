const Parser = require("simple-text-parser");

const {
  getHead,
  generateEmails,
} = require('./util');

const {
  generateContentParser,
} = require('./util-parser');

const parseFile = async () => {
  const parser = new Parser();
  const contentParser = generateContentParser(parser)

  for (let i = 0; i < 8; i++) {
    // SEVEN DAY KICKSTARTER
    generateEmails('email_seven_day_kickstarter', `sdk-day-${i}`, `template_seven_day_kickstarter_${i}.mjml`, contentParser);

    // SEVEN WEEK AWARENESS CHALLENGE
    generateEmails('email_seven_week_awareness_vol_1', `eswa-vol1-day-${i}`, `template_seven_week_awareness_vol_1_${i}.mjml`, contentParser);
    generateEmails('email_seven_week_awareness_vol_2', `eswa-vol2-day-${i}`, `template_seven_week_awareness_vol_2_${i}.mjml`, contentParser);
    generateEmails('email_seven_week_awareness_vol_3', `eswa-vol3-day-${i}`, `template_seven_week_awareness_vol_3_${i}.mjml`, contentParser);
    generateEmails('email_seven_week_awareness_vol_4', `eswa-vol4-day-${i}`, `template_seven_week_awareness_vol_4_${i}.mjml`, contentParser);
  }

  for (let i = 0; i < 11; i++) {
    // TEN DAY MEDITATION PRIMER
    // generateEmails('email_ten_day_meditation', `tdm-day-${i}`, `template_ten_day_meditation_${i}.mjml`, contentParser);
  }

};

parseFile();
