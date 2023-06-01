// //import
// //mian function
// //call the main function

const { network } = require("hardhat")
const { networkConfig, developmentNetworks } = require("../helper-hardhat-config")
const {verify} = require("../utils/verify")

// destructure the hardhat runtime environment (HRE) in the function declaration
module.exports = async ({getNamedAccounts, deployments}) => {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()
    const chainId = network.config.chainId
    const asset = "0xe96A22092FE7812D301D6bD78eC3E1E733a8D442"
    const name = "VAUU"
    const symbol = "VAU"
    const args = [asset, name, symbol]
    // setting conditionals for the network to be deployed to
    const ERC4626 = await deploy("ERC4626Vault", {
        from: deployer,
        args,
        log: true,
    })

    if(!developmentNetworks.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
        // verify
        await verify(ERC4626.address, args)
    }

    log("----------------------------------------")
}

module.exports.tags = ["all", "ERC4626Vault"]