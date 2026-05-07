import ballerina/email;
import ballerina/http;

// Shared HTTP client pointing to the external reporting API
public final http:Client apiClient = check new (apiBaseUrl, auth = {token: apiAuthToken});

// Shared SMTP client for sending email notifications
public final email:SmtpClient smtpClient = check new (
    smtpHost,
    username = smtpUsername,
    password = smtpPassword
);
