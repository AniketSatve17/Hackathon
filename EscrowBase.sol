// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EscrowBase {
    address public client;
    address public freelancer;
    address public arbiter;
    uint256 public totalMilestones;
    uint256 public milestoneAmount;
    uint256 public totalAmount;

    enum ProjectState { NotStarted, InProgress, Completed, Disputed }
    ProjectState public projectState;

    constructor(
        address _client,
        address _freelancer,
        address _arbiter,
        uint256 _totalMilestones
    ) {
        require(_client != address(0) && _freelancer != address(0) && _arbiter != address(0), "Invalid addresses");
        require(_totalMilestones > 0, "At least one milestone required");

        client = _client;
        freelancer = _freelancer;
        arbiter = _arbiter;
        totalMilestones = _totalMilestones;
        projectState = ProjectState.NotStarted;
    }
}
