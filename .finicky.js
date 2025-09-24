// ~/.finicky.js
export default {
  defaultBrowser: "Google Chrome",
  rewrite: [
    {
      // Redirect all x.com urls to use xcancel.com
      match: "x.com/*",
      url: (url) => {
        url.host = "xcancel.com";
        return url;
      },
    },
  ],
  handlers: [
    {
      // Open all bsky.app urls in Firefox
      match: "bsky.app/*",
      browser: "Comet",
    },
    {
      // Open all bsky.app urls in Firefox
      match: "tel:",
      browser: "Firefox",
    },
    {
      // Open google.com and *.google.com urls in Google Chrome
      match: [
        "google.com/*", // match google.com urls
        "*.google.com*", // also match google.com subdomains
      ],
      browser: "Google Chrome",
    },
  ],
};
