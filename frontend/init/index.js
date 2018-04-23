// Set up Turbolinks and ujs
import Rails from "rails-ujs";
Rails.start();
import Turbolinks from "turbolinks";
Turbolinks.start();
global.Rails = Rails;

// Jquery available in window
window.$ = window.jQuery = require("jquery");

// Set up images so all are imported by default
require.context("../images/", true, /\.(gif|jpg|png|svg)$/i);

// House imports
import "bootstrap";
import "components";
import "styles";
import "app";

console.log("Hello World from Webpacker");
