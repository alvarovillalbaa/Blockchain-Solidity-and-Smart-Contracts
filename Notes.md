Blockchain is a disruptive technology focused on data encryption for its usage. Solidity represents the functionality and JavaScript or other language sets the ground for its data structure.

'''
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
'''

