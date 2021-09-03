// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "./GushlyImplementation.sol";

contract GushlyFactory {
    address public admin;

    mapping(address => GushlyImplementation[]) private gushlyEmployerContracts; // array of addresses
    mapping(address => GushlyImplementation[]) private gushlyEmployeeContracts; // array of addresses
    mapping(address => uint256) internal balances;

    constructor() {
        admin = msg.sender;
    }

    function createContract(
        address _employee,
        uint256 _expiry,
        bool _payByHour,
        uint256 _hourlyRate,
        uint256 _projectRate
    ) external {
        require(_employee != msg.sender);

        GushlyImplementation newContract = new GushlyImplementation(
            msg.sender,
            _employee,
            _expiry,
            _payByHour,
            _hourlyRate,
            _projectRate
        );

        gushlyEmployerContracts[msg.sender].push(newContract);
        gushlyEmployeeContracts[_employee].push(newContract);
    }

    function getEmployerContracts()
        external
        view
        returns (GushlyImplementation[] memory)
    {
        return gushlyEmployerContracts[msg.sender];
    }

    function getEmployeeContracts()
        external
        view
        returns (GushlyImplementation[] memory)
    {
        return gushlyEmployeeContracts[msg.sender];
    }
}
