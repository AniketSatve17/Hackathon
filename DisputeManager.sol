// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./EscrowBase.sol";

contract DisputeManager is EscrowBase {
    event DisputeRaised(address indexed by, string reason);
    event DisputeResolved(address indexed resolver, bool favorClient);

    constructor(
        address _client,
        address _freelancer,
        address _arbiter,
        uint256 _totalMilestones
    ) EscrowBase(_client, _freelancer, _arbiter, _totalMilestones) {}

    function raiseDispute(string memory reason) external {
        require(msg.sender == client || msg.sender == freelancer, "Only client or freelancer can raise dispute");
        projectState = ProjectState.Disputed;
        emit DisputeRaised(msg.sender, reason);
    }

    function resolveDispute(bool favorClient) external {
        require(msg.sender == arbiter, "Only arbiter can resolve dispute");

        if (favorClient) {
            payable(client).transfer(address(this).balance);
        } else {
            payable(freelancer).transfer(address(this).balance);
        }

        projectState = ProjectState.Completed;
        emit DisputeResolved(msg.sender, favorClient);
    }
}
