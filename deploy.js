const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Set addresses
    const client = "0x9aaa47E69eB507a4510bbC7Ba745A5BBeA6c718c"; 
    const freelancer = "0x60B1CdbcC9165F5cE068A1Ce8ad7fB384d3aa3Da"; 
    const arbiter = "0x70d733aef29D3Dd347a61Fb020BA6C77d5C6fb3C"; 
    const totalMilestones = 3; 

    // Deploy EscrowBase contract
    const EscrowBase = await hre.ethers.getContractFactory("EscrowBase");
    const escrow = await EscrowBase.deploy(client, freelancer, arbiter, totalMilestones, { value: hre.ethers.parseEther("5") });

    await escrow.waitForDeployment();
    console.log("Escrow contract deployed at:", await escrow.getAddress());
}

main().catch((error) => {
    console.error("Deployment error:", error);
    process.exit(1);
});
