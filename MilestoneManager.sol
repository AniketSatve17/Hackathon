// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./EscrowBase.sol";

contract MilestoneManager is EscrowBase {
    uint256 public currentMilestone;

    event MilestoneCompleted(uint256 milestone, address freelancer);
    event FundsReleased(uint256 amount, address freelancer);

    constructor(
        address _client,
        address _freelancer,
        address _arbiter,
        uint256 _totalMilestones
    ) EscrowBase(_client, _freelancer, _arbiter, _totalMilestones) {}

    function completeMilestone() external {
        require(msg.sender == freelancer, "Only freelancer can mark milestone complete");
        require(currentMilestone < totalMilestones, "All milestones completed");

        currentMilestone++;
        emit MilestoneCompleted(currentMilestone, freelancer);
    }

    function releaseFunds() external {
        require(msg.sender == client, "Only client can release funds");
        require(currentMilestone > 0, "No milestone completed yet");

        uint256 payment = milestoneAmount;
        payable(freelancer).transfer(payment);

        emit FundsReleased(payment, freelancer);
    }
}
