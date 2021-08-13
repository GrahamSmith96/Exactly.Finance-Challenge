// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const[deployer] = await ethers.getSigners();

  console.log("Deploying ethPool with the account:", deployer.address);


  const ETHPool = await ethers.getContractFactory("ETHPool");
  const ethPool = await ETHPool.deploy(deployer.address);

  console.log("ethPool address:", ethPool.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
