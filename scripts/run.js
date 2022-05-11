const { ethers } = require("hardhat");

const main = async () => {
    
    // This will actually compule our contract and generate the necessary
    // files need to work with our contract under the artifacts
    // directory

    const coffeeContractFactory = await  hre.ethers.getContractFactory('CoffeePortal')

    const coffeeContract = await coffeeContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")},); // We'll wait until our contract is officially deployed to out local blockchain. Our constructor runs when we actually deploy
    
    await coffeeContract.deployed();
    console.log("Coffee contract deployed to:", coffeeContract.address);

    // Get Contract balance
    let contractBalance = await hre.ethers.provider.getBalance(coffeeContract.address);
    console.log("Contract balance:", hre.ether.utils.formatEther(contractBalance));

    // Try to buy a coffee
    const coffeeTxn = await coffeeContract.buyCoffee(
        "This is coffee #1",
        "Daval",
        ethers.utils.parseEther("0.001")
    );
    await coffeeTxn.wait();


    // Get the contract balance to see what happened
    contractBalance = await hre.ethers.provider.getBalance(
        coffeeContract.address
    );
    console.log("Contract balances:", hre.ethers.utils.formatEther(contractBalance));

    let allCoffee = await coffeeContract.getAllCoffee();
    console.log(allCoffee);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();