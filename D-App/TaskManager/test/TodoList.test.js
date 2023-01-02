// writing test

const { assert } = require("chai");

const TodoList = artifacts.require("./TodoList.sol");

contract("TodoList", (accounts) => {
    before(async () => {
        this.todoList = await TodoList.deployed();
    });

    it("deploys successfully", async () => {
        const address = await this.todoList.address;
        assert.notEqual(address, 0x0);
        assert.notEqual(address, "");
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
    });

    // it("lists tasks", async () => {
    //     // basic tests
    //     const taskCount = await this.todoList.taskCount();

    //     const task = await this.todoList.tasks(taskCount);

    //     assert.equal(task.id.toNumber(), taskCount.toNumber());
    //     assert.equal(task.content, "Creating my first task");
    //     assert.equal(task.completed, false);
    //     assert.equal(taskCount.toNumber(), 1);
    // });

    it("creates tasks", async () => {
        // test for creating a new task

        const currTime = Date.now();

        const result = await this.todoList.createTask("A new task", currTime);
        const taskCount = await this.todoList.taskCount();

        assert.equal(taskCount, 1);

        const event = result.logs[0].args;
        assert.equal(event.id.toNumber(), 1);
        assert.equal(event.content, "A new task");
        assert.equal(event.completed, false);
        assert.equal(event.createdAt, currTime);
    });

    it("toggle completed", async () => {
        // test for task completion toggle

        const result = await this.todoList.toggleCompleted(1);
        const task = await this.todoList.tasks(1);
        assert.equal(task.completed, true);
        const event = result.logs[0].args;
        assert.equal(event.id.toNumber(), 1);
        assert.equal(event.completed, true);
    });
});
