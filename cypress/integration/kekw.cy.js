describe('Homepage spec', () => {
  it('passes', () => {
    cy.visit('http://127.0.0.1:45678')
  })

  it("has no items in the cart initially", () => {
    cy.contains("My Cart (0)");
  });

  it("clicks on the 'Add' button for the first product on the page", () => {
    cy.get(".products article")
      .first()
      .contains("Add")
      .click({ force: true });
  });

  it("has an item in the cart afterwards", () => {
    cy.contains("My Cart (1)");
  });
})