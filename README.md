# cookbook-appwatch Cookbook

This cookbook includes a default recipe to add a service to logwatch to monitor application output,
and a cookbook file with a python class to help create correspondingly-formatted log entries.

## Berkshelf and librarian
```ruby
  # Berkshelf:
  cookbook 'appwatch', github: 'flatrocks/cookbook-appwatch', tag: '0.3.0'


  # librarian-chef:
  cookbook 'appwatch', github: 'flatrocks/cookbook-appwatch', ref: '0.3.0'
```

## Appwatch service for logwatch

Creates appwatch service for logwatch.
The idea is for python scripts to output various event information to the syslog,
and have a way for logwatch to include it in a prominent section to avoid either 1) creating a new
log or 2) having to make each python script handle it's own logging and/or email notifications.

The service includes these files:

The perl script that parses the syslog:

    /etc/logwatch/scripts/services/appwatch

The config file simply associates the "appwatch" service with the syslog log files:

    /etc/logwatch/conf/services/appwatch.conf

## The python class

The app_logger.py file implements the AppLogger class.
The class new() method takes the app name as an argument and there are two instance methods:
```
    logwatch_instance = Logwatch.new('my_app')

    logwatch_instance.log_info('Something happened.')

    logwatch_instance.log_error('Rats, an error.')
```
Each formats and writes the message to the syslog in a form that can be captured by the appwatch service.

## Formatting and logwatch detail level

Messages logged using the log_info method will be logged in this format:

    <syslog timestamp> APP[app name]: Message here

Messages logged using the log_error method will be logged in this format:

    <syslog timestamp> APP[app name]: ERROR Message here

When logwatch --detail level is Low (\<5) only the error entries will be included oin the output.
When logwatch --detail level is Med (5) or higher, all entries will be included.

