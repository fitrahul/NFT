const hre = require("hardhat");

async function main() {
  const [lawer] = await hre.ethers.getSigners();

  const DragonBallZ1155 = await hre.ethers.getContractFactory("DragonBallZ1155");
  const dragonBallZ1155 = await DragonBallZ1155.connect(lawer).deploy("DragonBallZ1155", "DB1155");
  await dragonBallZ1155.deployed();

  console.log("DragonBallZ1155 Address: ", dragonBallZ1155.address);

  // pass amount and json file url(app.pinata.cloud)
  const nft = await dragonBallZ1155.mint(
    10,
    "https://ipfs.io/ipfs/QmQiGeGjoR4wZoC9c1149Tpnctrfa35VYj2bPnaa1YGmh9"
  )
  console.log("NFT: ", nft);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
