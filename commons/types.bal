// Shared task types used across integrations

public type Task record {|
    int taskId;
    string title;
    string description;
    string status;
|};

public type NewTask record {|
    string title;
    string description;
|};

public type FileEvent record {|
    string filePath;
    string operation;
    string timestamp;
|};
