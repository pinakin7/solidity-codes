// smart contract for todo list
// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0;

contract TodoList{
    // keep track for number of task in the list

    // declaring the state variable
    uint public taskCount = 0;

    // creating our own data type
    struct Task {
        uint id;
        string content;
        bool completed;
        uint256 createdAt;
    }

    // put this on the blockchain storage

    mapping(uint => Task) public tasks;  // Mapping on the blockchain id -> mapping a task

    event TaskCreated(
        uint id,
        string content,
        bool completed,
        uint256 createdAt
    );

    event TaskCompleted(
        uint id,
        bool completed
    );

    // setting the constructor
    // constructor() public {
    //     // createTask("Creating my first task", 0);
    // }

    // putting a task inside of the mapping
    function createTask(string memory _content, uint256 _timestamp) public {
        taskCount ++;
        tasks[taskCount] = Task(taskCount, _content, false, _timestamp);

        // broadcasting an event 

        emit TaskCreated(taskCount, _content, false, _timestamp);
    }

    function toggleCompleted(uint _id) public {
        Task memory _currTask = tasks[_id];

        _currTask.completed = !_currTask.completed;
        tasks[_id] = _currTask;

        emit TaskCompleted(_id, _currTask.completed);
    }   

}