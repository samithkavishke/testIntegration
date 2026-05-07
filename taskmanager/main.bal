import ballerina/http;
import ballerina/log;

// In-memory task store
map<Task> taskStore = {};
int nextTaskId = 1;

type Task record {|
    int taskId;
    string title;
    string description;
    string status;
|};

type NewTask record {|
    string title;
    string description;
|};

listener http:Listener taskListener = check new http:Listener(8080);

service /tasks on taskListener {

    // List all tasks
    resource function get .() returns Task[] {
        return taskStore.toArray();
    }

    // Get a single task by ID
    resource function get [int taskId]() returns Task|http:NotFound {
        Task? foundTask = taskStore[taskId.toString()];
        if foundTask is () {
            return http:NOT_FOUND;
        }
        return foundTask;
    }

    // Create a new task
    resource function post .(NewTask payload) returns Task|http:Created {
        int currentId = nextTaskId;
        nextTaskId += 1;
        Task newTask = {
            taskId: currentId,
            title: payload.title,
            description: payload.description,
            status: "pending"
        };
        taskStore[currentId.toString()] = newTask;
        log:printInfo(string `Task created: [${currentId}] ${payload.title}`);
        return newTask;
    }

    // Mark a task as done
    resource function put [int taskId]/done() returns Task|http:NotFound {
        Task? existingTask = taskStore[taskId.toString()];
        if existingTask is () {
            return http:NOT_FOUND;
        }
        Task updatedTask = {
            taskId: existingTask.taskId,
            title: existingTask.title,
            description: existingTask.description,
            status: "done"
        };
        taskStore[taskId.toString()] = updatedTask;
        log:printInfo(string `Task marked as done: [${taskId}] ${existingTask.title}`);
        return updatedTask;
    }

    // Delete a task
    resource function delete [int taskId]() returns http:Ok|http:NotFound {
        Task? existingTask = taskStore[taskId.toString()];
        if existingTask is () {
            return http:NOT_FOUND;
        }
        _ = taskStore.remove(taskId.toString());
        log:printInfo(string `Task deleted: [${taskId}]`);
        return http:OK;
    }
}

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
}

listener http:Listener httpDefaultListener1 = http:getDefaultListener();

service / on httpDefaultListener1 {
}
