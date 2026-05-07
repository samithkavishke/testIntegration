import ballerina/time;
import wso2/strict.library as _;


// Returns a formatted UTC timestamp string
public function getCurrentTimestamp() returns string {
    time:Utc currentUtc = time:utcNow();
    time:Civil civilTime = time:utcToCivil(currentUtc);
    string secondStr = civilTime.second is () ? "00" : civilTime.second.toString();
    return string `${civilTime.year}-${civilTime.month}-${civilTime.day} ${civilTime.hour}:${civilTime.minute}:${secondStr}`;
}

// Builds a standard log message with a prefix label
public function buildLogMessage(string label, string message) returns string {
    return string `[${label}] ${getCurrentTimestamp()} - ${message}`;
}
