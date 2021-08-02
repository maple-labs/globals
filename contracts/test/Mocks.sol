// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

contract CalculatorMock {

    uint8 public calcType;
    
    constructor(uint8 _calcType) public {
        calcType = _calcType;
    }
    
}


contract OracleMock {

    function getLatestPrice() external pure returns (uint256) {
        return 100;
    }

}


contract SubFactoryMock {

    uint8 public factoryType;
    
    constructor(uint8 _factoryType) public {
        factoryType = _factoryType;
    }

}


contract TokenMock {

    string  public constant symbol   = "TKN";
    uint256 public constant decimals = 18;

}
