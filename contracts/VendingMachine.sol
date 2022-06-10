//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./Owner.sol";

contract VendingMachine is Owner {
    struct Item {
        uint id;
        string name;
        uint32 quantity;
    }

    mapping(string => Item) public itemDetails;
    uint private counter = 1;

    function addItem(string calldata _name, uint8 _quantity) public onlyOwner {
        require(itemDetails[_name].id == 0, "Item already available");
        itemDetails[_name] = Item({
            id: counter,
            name: _name,
            quantity: _quantity
        });
        counter++;
    }

    function restock(string calldata _name, uint32 _quantity) public {
        require(itemDetails[_name].id != 0, "Item not available");
        itemDetails[_name].quantity += _quantity;
    }

    function purchase(string calldata _name, uint32 _quantity) public {
        require(
            itemDetails[_name].quantity >= _quantity,
            "Not Enough quantity available"
        );
        itemDetails[_name].quantity -= _quantity;
    }
}
