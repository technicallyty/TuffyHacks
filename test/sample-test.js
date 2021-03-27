const { BigNumber } = require("@ethersproject/bignumber");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token", function() {
  it("Should create a token", async function() {
    const Token = await ethers.getContractFactory("TuffyToken");
    const token = await Token.deploy(2000000);
    await token.deployed();

    const signers = await ethers.getSigners();
    let addr1 = signers[1].getAddress();
    await token._transfer(addr1, 35);
    let tokens = await token._balanceOf(addr1);
    console.log(tokens.toNumber());
    //  expect(await token.greet()).to.equal("Hello, world!");

    //  await greeter.setGreeting("Hola, mundo!");
    //  expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
