
/* global ethers task */
require('@nomiclabs/hardhat-waffle')
require('hardhat-gas-reporter');
require("hardhat-contract-sizer");
require("@nomiclabs/hardhat-etherscan");


// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  gasReporter: {
    enabled: (process.env.REPORT_GAS) = true, // will give report if REPORT_GAS environment variable is true
    currency: 'USD', // can be set to ETH and other currencies (see coinmarketcap api documentation)
    coinmarketcap: process.env.coinMarketCap_API, // to fetch prices from coinmarketcap api
    reportFormat: "markdown",
    outputFile: "../data/gasReport.md",
    outputJSON: true,
    outputJSONFile: "../data/gas.json",
    includeBytecodeInJSON: false,
    forceTerminalOutput: true,
    forceTerminalOutputFormat: "terminal"
  }
  
}
