// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract CoffeePortal {
    uint256 totalCoffee;

    address payable public owner;

    event NewCoffee(
        address indexed from,
        uint256 timestamp,
        string message,
        string name
    );


    constructor() payable {
        console.log("Yo, smart contract!");

        // user who is calling this function address
        owner = payable(msg.sender);
    }

        // Struct named Coffee
        // A struct is basically custom datatype where we can customize what we want tohold inside it
        struct Coffee {
            address giver; // The address of the iser who buys me a coffee
            string message; // The message the user sent
            string name; // The name of the user who buys me a coffee
            uint256 timestamp; // The timestamp when the user buys me a coffee
        }

        /**
        I declare variable coffee that let me store an array of strucs
        This is what lets me hold all the coffee anyone eve sends to me
         */
         Coffee[] coffee;

         /**
            I need a function getAllCoffee which will return the struct array, coffee, to us
            This will make it easy to retrieve the coffee from our website!
          */
          function getAllCoffee() public view returns (Coffee[] memory) {
              return coffee;
        }

        // Get all coffee bought
        function getTotalCoffee() public view returns (uint256) {
            console.log("We have %d total coffee received", totalCoffee);
            return totalCoffee;
        }

        function buyCoffee(
            string memory _message,
            string memory _name,
            uint256 _payAmount
        ) public payable {
            uint256 cost = 0.001 ether;
            require(_payAmount <= cost, "Insufficient Ether provided");

            totalCoffee += 1;
            console.log("%s has just sent a coffee!", msg.sender);

            /**
            This is where I actually store the coffee data in the array.
             */
             coffee.push(Coffee(msg.sender, _message, _name, block.timestamp));

             (bool success, ) = owner.call{value: _payAmount}("");
             require(success, "Failed to send money");

             emit NewCoffee(msg.sender, block.timestamp, _message, _name);

        }


}