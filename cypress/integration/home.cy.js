describe('empty spec', () => {
  it('passes', () => {
    cy.visit('http://127.0.0.1:45678')
  })

  it("finds products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})