// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainSustainability {
    // Define a struct to represent product details
    struct Product {
        uint id;
        string name;
        uint quantity;
        bool isSustainable;
        address currentOwner;
        uint timestamp;
    }

    // Declare a mapping to store products by their ID
    mapping(uint => Product) public products;
    uint public productCount;

    // Event to be emitted when a product is added or transferred
    event ProductAdded(uint productId, string productName, uint quantity, bool isSustainable);
    event ProductTransferred(uint productId, address newOwner);

    // Function to add a new product to the supply chain
    function addProduct(string memory _name, uint _quantity, bool _isSustainable) public {
        productCount++;
        products[productCount] = Product(productCount, _name, _quantity, _isSustainable, msg.sender, block.timestamp);

        emit ProductAdded(productCount, _name, _quantity, _isSustainable);
    }

    // Function to transfer ownership of a product in the supply chain
    function transferOwnership(uint _productId, address _newOwner) public {
        require(_productId > 0 && _productId <= productCount, "Product not found.");
        require(msg.sender == products[_productId].currentOwner, "Only the current owner can transfer ownership.");

        products[_productId].currentOwner = _newOwner;

        emit ProductTransferred(_productId, _newOwner);
    }

    // Function to check product details
    function getProductDetails(uint _productId) public view returns (string memory name, uint quantity, bool isSustainable, address currentOwner, uint timestamp) {
        require(_productId > 0 && _productId <= productCount, "Product not found.");
        Product memory p = products[_productId];
        return (p.name, p.quantity, p.isSustainable, p.currentOwner, p.timestamp);
    }
}
