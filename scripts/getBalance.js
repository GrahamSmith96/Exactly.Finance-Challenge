const { providers } = require("ethers");
const hre = require("hardhat");

async function main() {
    
    const balance = await providers.getBalance("0x5fbdb2315678afecb367f032d93f642f64180aa3");

    console.log("ethPool has a total amount of:", ethers.utils.formatEther(balance));
    
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });