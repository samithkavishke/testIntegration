import ballerina/file;
import ballerina/graphql;
import ballerina/log;

import samith/commons;

listener file:Listener fileListener = new (path = "./tmp", recursive = false);

service file:Service on fileListener {
    remote function onModify(file:FileEvent event) returns error? {
        do {
            log:printInfo(string `${event.operation}+ Files Modified`);
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}

listener graphql:Listener graphqlListener = new (8080);

service /graphql on graphqlListener {
    resource function get Q1() returns commons:TaskSummary {
    }

    resource function subscribe S1() returns MyType {
    }
}

