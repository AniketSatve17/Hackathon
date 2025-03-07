require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ethers");
require("dotenv").config();

module.exports = {
    solidity: "0.8.20",
    networks: {
        scroll: {
            url: process.env.SCROLL_RPC_URL || "https://sepolia-rpc.scroll.io",
            accounts: [process.env.PRIVATE_KEY],
        },
    },
};


