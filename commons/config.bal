// Shared configurable values for all integrations

// HTTP service port for the Task Manager
public configurable int servicePort = 8080;

// File watcher directory path
public configurable string watchDirectory = "./tmp";

// Notification email settings
public configurable string smtpHost = ?;
public configurable string smtpUsername = ?;
public configurable string smtpPassword = ?;
public configurable string notificationEmail = ?;

// External API base URL (e.g. a backend reporting service)
public configurable string apiBaseUrl = ?;
public configurable string apiAuthToken = ?;
