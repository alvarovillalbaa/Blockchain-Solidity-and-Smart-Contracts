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
