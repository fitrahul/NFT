const hre = require("hardhat");

async function main() {
  const [lawyer] = await hre.ethers.getSigners();

  const RahulToken = await hre.ethers.getContractFactory("RahulToken");
  const token = await RahulToken.connect(lawyer).deploy(1000);
  await token.deployed();

  console.log(token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
