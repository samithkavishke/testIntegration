import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get foo() returns json|error {
        do {
            log:printWarn("Hi");
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
