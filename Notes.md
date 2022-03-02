Blockchain is a disruptive technology focused on data encryption for its usage. Solidity represents the functionality and JavaScript or other language sets the ground for its data structure.

# Data Storage
```
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Notes {

    //This will get initialized to 0!
    uint256 public favoriteNumber;

    //We can see more data types in the Solidity Documentation
    bool favoriteBool = true;
    string favoriteString = "First Blockchain Project";
    int256 favoriteInt = -7;
    address favoriteAddress = 0x4FBa8E809939Cf2B4f56acF78aAA79714539bf5F;
    bytes32 favoriteBytes = "cat";

    function store1(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        uint256 test = 4;
    }
    //Visibility Types (e.g. public) set the scope of the UI. Set in internal by default.

    function store2() public {
        //Outside of the scope of function 'store1'
    }

    //View and Pure are two non-state changing functions
    //View means doing some reads from the blockhain
    //Pure just do some math, but not saving the state changing function 
    function retrieve() public view returns(unit256) {
        return favoriteNumber;
    }

    //Struct keyword is like creating an object
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    People public person = People({favoriteNumber : 2, name : "Alvaro"});

    //Arrays have an arbitrary size if not specified
    //Memory speifies that it'll only be store during execution.
    //storage means that it'll also persist during funtion execution
    People[] public people;
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber : _favoriteNumber, name : _name}));
        // Alternative:
        people.push(People({favoriteNumber : _favoriteNumber, name : _name}));
    }

    //Strings is actually an array of characters.
    //Mapping takes some key and outputs its variable
    mapping(string => uint256) public nameToFavoriteNumber;
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
```

# Factory Storage
```
//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./DataStorage.sol"; //Calling a prototyped function/contract

contract StorageFactory is DataStorage { //Then the new contract inherits variables and functions
    DataStorage[] public dataStorageArray;

    function createDataStorageContract() public {
        DataStorage dataStorage = new DataStorage(); //We are creating an object with DataStorage called dataStorage
        dataStorageArray.push(dataStorage);
    }

    function sfStore(uint256 _dataStorageIndex, uint256 _dataStorageNumber) public {
        //Everytime we want to interact with a contract we'll need its address and its ABI(App Binary Interface)
        DataStorage dataStorage = DataStorage(address(dataStorageArray[_dataStorageIndex]));
    }

    function sfGet(uint256 _dataStorageIndex) public view returns(uint256) {
        DataStorage dataStorage = DataStorage(address(dataStorageArray[_dataStorageIndex]));
        return dataStorage.retrieve();
    }
}
```

# Fund Ukraine
```
//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundUkraine {
    using SafeMathChainlink for uint256; //It will prevent overflow for <=v0.8.0.sol

    mapping(address => uint256) public addressToAmountFunded;
    //When mapping is initialized, every key is essentially initialized, so we can loop through them by making an array in order to reset their balances to zero
    address[] public funders;

    address public owner;

    constructor() public {
        //Constructor calls the function at the time the contract is deployed
        owner = msg.sender;
    }
    function fund() public payable{
        // $5 as minimum threshold. Revert is an implicit function.
        uint256 minimumUSD = 10 ** 18;
        // if(msg.value < minimumUSD) { revert;} is an alternative to the next code:
        require(getConversionRate(msg.value) >= minimumUSD, "Minimum is 5USD!");
        //Every transaction will have a different value and the button will be red(from payable)
        addressToAmountFunded[msg.sender] += msg.value;
        //What is the ETHH -> conversion rate?!?!?!
        funders.push(msg.sender);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return priceFeed.version();
    }
    //ABI(App Binary Interface) tells how to interact with another contract
    //We'll put the address of the ETH/USD address in the mainnet we want: docs.chain.link/docs/ethereum-addresses/

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (,int256 answer ,,,) = priceFeed.latestRoundData();
        return uint256(answer * 10000000);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getprice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000;
        return ethAmountInUsd;
    }

    // A modifier is used to change the behaviour of a function in a declarative way
    modifier onlyOwner {
        require(msg.sender == owner);
        _; //Why is this???
    }

    function withdraw() public payable {
        // We only want the contract admin/owner
        // require(msg.sender == owner); if not used modifier
        msg.sender.transfer(address(this).balance);
        //(this) refers to the contract  you're in, in this case the address
        for (uint256 funderIndex = 0; underIndex < funders.length; funders++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
```

# Overflow
Avoiding compiling errors when using <= v0.8.0 of Solidity.
```
// SDPX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Overflow {

    function overfflow() public view returns(uint8){
        uint8 big = 255 + uint(100); //Wrapping functionality
        return big;
    }
}
```
