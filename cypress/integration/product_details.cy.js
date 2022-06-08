describe('products', () => {

  it('visits the page', () => {
    cy.visit('http://127.0.0.1:45678')
  })

  it("finds products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("can click on one of the items to visit their page", () => {
    cy.get(".products article").first().click();
  });

  it("contains the expected text", () => {
    cy.get("article").contains("Scented Blade")
    cy.get("article").contains("The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.")
    cy.get("article").contains("18 in stock at")
    cy.get("article").contains("$24.99")
  });

  it("contains a button to add to the cart", () => {
    cy.get("article").get("button").contains("Add")
  });
})