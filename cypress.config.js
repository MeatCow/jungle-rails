const { defineConfig } = require("cypress");

module.exports = defineConfig({
  screenshotsFolder: "tmp/cypress_screenshots",
  videosFolder: "tmp/cypress_videos",
  trashAssetsBeforeRuns: false,

  e2e: {
    specPattern: "cypress/integration/**/*.cy.{js,jsx,ts,tsx}",
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
