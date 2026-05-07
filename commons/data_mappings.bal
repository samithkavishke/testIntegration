import ballerina/email;

// Maps a Task to an email notification message
public function taskToEmailMessage(Task taskItem, string action) returns email:Message {
    string subject = string `Task ${action}: [#${taskItem.taskId}] ${taskItem.title}`;
    string body = string `Task Details:
  ID          : ${taskItem.taskId}
  Title       : ${taskItem.title}
  Description : ${taskItem.description}
  Status      : ${taskItem.status}
  Action      : ${action}
  Timestamp   : ${getCurrentTimestamp()}`;

    return {
        to: notificationEmail,
        subject: subject,
        'from: smtpUsername,
        body: body
    };
}

// Maps a FileEvent to an email notification message
public function fileEventToEmailMessage(FileEvent fileEvent) returns email:Message {
    string subject = string `File ${fileEvent.operation}: ${fileEvent.filePath}`;
    string body = string `File Event Details:
  File      : ${fileEvent.filePath}
  Operation : ${fileEvent.operation}
  Timestamp : ${fileEvent.timestamp}`;

    return {
        to: notificationEmail,
        subject: subject,
        'from: smtpUsername,
        body: body
    };
}

// Maps a Task to a plain summary record for API reporting
public type TaskSummary record {|
    string taskRef;
    string title;
    string currentStatus;
    string reportedAt;
|};

public function taskToSummary(Task taskItem) returns TaskSummary {
    return {
        taskRef: string `TASK-${taskItem.taskId}`,
        title: taskItem.title,
        currentStatus: taskItem.status,
        reportedAt: getCurrentTimestamp()
    };
}

// Maps a FileEvent to a plain summary record for API reporting
public type FileEventSummary record {|
    string filePath;
    string operation;
    string detectedAt;
|};

public function fileEventToSummary(FileEvent fileEvent) returns FileEventSummary {
    return {
        filePath: fileEvent.filePath,
        operation: fileEvent.operation,
        detectedAt: fileEvent.timestamp
    };
}

function transform(FileEventSummary Name1) returns TaskSummary => {
    reportedAt: "",
    taskRef: "",
    currentStatus: "",
    title: ""
};
