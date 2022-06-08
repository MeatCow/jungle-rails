describe('Login spec', () => {
  it('navigates to the homepage', () => {
    cy.visit('http://127.0.0.1:45678')
  });

  it("clicks on the login button", () => {
    cy.contains("Login")
      .click()
  });

  it("fills the form and click Submit", () => {
    console.log(JSON.stringify(process.env))
    cy.get(`input[name="email"]`)
      .type("matthieu.pauze@gmail.com")

    cy.get(`input[name="password"]`)
      .type("hello world!")

    cy.contains("Submit")
      .click()
  });

  it("redirects to the homepage with the firstname showing", () => {
    cy.contains("Signed in as Matt")
  })
})