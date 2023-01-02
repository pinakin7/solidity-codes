App = {
    ethereumProvider: window.ethereum,
    contracts: {},
    load: async () => {
        // Load application
        await App.loadWeb3();

        await App.loadContract();

        await App.render();

        // console.log("App is Loading");
    },
    loadWeb3: async () => {

        // window.ethereum
        // conneccting to the metamask


        const accounts = await ethereum.request({ method: 'eth_requestAccounts' });

        // console.log(accounts);

        App.account = accounts[0];

    },
    loadContract: async () => {
        const todoList = await $.getJSON('TodoList.json');

        App.contracts.TodoList = TruffleContract(todoList);

        App.contracts.TodoList.setProvider(App.ethereumProvider);

        // console.log(todoList);

        App.todoList = await App.contracts.TodoList.deployed();
    },
    render: async ()=>{
        $("#accountAddress").html(App.account);

        await App.renderTasks();
    },
    renderTasks: async ()=>{

        // render all tasks
        // render task using task templates

        const listItemColorScheme = [
            "list-group-item-primary",
            "list-group-item-secondary",
            "list-group-item-danger",
            "list-group-item-warning",
            "list-group-item-light",
            "list-group-item-dark",
            "list-group-item-info",
            "list-group-item-success",
        ]
        
        const taskCount = await App.todoList.taskCount();

        const $taskTemplate = $(".taskTemplate");

        for (let index = 0; index <= taskCount; index++) {
            const task = await App.todoList.tasks(index);
            const taskId = task[0].toNumber();
            const taskContent = task[1];
            const taskCompleted = task[2];
            let taskCreatedAt = task[3].toNumber();
            taskCreatedAt = new Date(taskCreatedAt);
            taskCreatedAt = taskCreatedAt.toDateString();
        
            if(taskContent.length<=0)continue;

            const $newTaskTemplate = $taskTemplate.clone();

            let randomIndex = Math.floor(Math.random() * listItemColorScheme.length);

            $newTaskTemplate.find("label").addClass(listItemColorScheme[randomIndex]);
            $newTaskTemplate.find('.content').addClass(taskCompleted?"text-decoration-line-through":"");
            $newTaskTemplate.find('.content').html(taskContent);
            $newTaskTemplate.find('input').prop('name', taskId).prop('checked', taskCompleted).on('click', App.toggleCompleted);

            $newTaskTemplate.find('.badge').html(taskCreatedAt);

            $('#taskList').append($newTaskTemplate);

            $newTaskTemplate.show();
        }
    },
    addTask: async ()=>{
        const content = $("#taskContent").val();

        await App.todoList.createTask(content, Date.now(), {from:App.account});

        window.location.reload();
    },
    toggleCompleted: async (event) => {
        const taskId = event.target.name;
        await App.todoList.toggleCompleted(taskId, {from:App.account});
        window.location.reload();
    },
}

$(() => {
    $(window).on("load", () => {
        App.load()
    })
})