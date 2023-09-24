
const { expect } = require("chai");
const { ethers } = require("hardhat");



describe("DegenToken", function () {
  let owner;
  let user1;
  let degenToken;

  

  beforeEach(async () => {
    [owner, user1] = await ethers.getSigners();

    const DegenToken = await ethers.getContractFactory("DegenToken");
    degenToken = await DegenToken.deploy();
    // await degenToken.deployed();
  });

  it("Should deploy the contract with the correct name and symbol", async function () {
    expect(await degenToken.name()).to.equal("Degen");
    expect(await degenToken.symbol()).to.equal("DGN");
  });

  it("Should mint tokens to the owner", async function () {
    const initialBalance = await degenToken.balanceOf(owner.address);
    const amountToMint = ethers.parseEther("2"); // Mint 1000 DGN (adjust as needed)

    await degenToken.connect(owner).mint(owner.address, amountToMint);

    const finalBalance = await degenToken.balanceOf(owner.address);

    const balanceChange = finalBalance-(initialBalance);

    // Convert amountToMint to BigNumber for comparison
    const expectedChange = ethers.parseEther("2");

    // Compare the balance change with the expected change
    expect(balanceChange).to.equal(expectedChange);
  });

  it("Should not allow minting by non-owner", async function () {
    const nonOwner = user1;
    const amountToMint = ethers.parseEther("2"); // Mint 1000 DGN (adjust as needed)

    await expect(degenToken.connect(nonOwner).mint(owner.address, amountToMint)).to.be.revertedWith(
      "Ownable: caller is not the owner"
    );
  });
});
