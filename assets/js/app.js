// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";
// import "../css/_main.scss";

// // // hub
// import "../css/_hub_header.scss";
// import "../css/_hub.scss";
// import "../css/_hub_sidebar.scss";

// // templates 
// import "../css/_header.scss";
// import "../css/_account_info.scss";
// import "../css/_box_info.scss";
// import "../css/_breadcrumbs.scss";
// import "../css/_footer.scss";

// // pages
// import "../css/_homepage.scss";
// import "../css/_courses.scss";
// import "../css/_single.scss";
// import "../css/_page.scss";
// import "../css/_account.scss";

// // components
// import "../css/_posts.scss";
// import "../css/_five_principles.scss";
// import "../css/_button.scss";

// // miscellaneous
// import "../css/_javascript.scss";
// import "../css/_form.scss";
// import "../css/_shortcodes.scss";


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
