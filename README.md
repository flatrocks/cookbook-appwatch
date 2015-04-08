# cookbook-appwatch Cookbook

This cookbook includes a default recipe to add a service to logwatch to monitor application output,
and a cookbook file with a python class to help create correspondingly-formatted log entries.

## Berkshelf and librarian
```ruby
  # Berkshelf:
  cookbook 'appwatch', github: 'flatrocks/cookbook-appwatch', tag: '0.1.1'


  # librarian-chef:
  cookbook 'appwatch', github: 'flatrocks/cookbook-appwatch', ref: '0.1.1'
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

The app_logger.py file provides an example of how to use app_watch by implementing an AppLogger class.
The class new() method takes the app name as an argument and there are two instance methods:
```python
    logwatch_instance = Logwatch.new('my_app')

    logwatch_instance.log_info('Something happened.')

    logwatch_instance.log_error('Rats, an error.')
```
Each formats and writes the message to the syslog in a form that can be captured by the appwatch service.

## Ruby

To use this facility in Ruby scripts, you can create system log messages like this:
```ruby
    require 'syslog'
    # Info level
    Syslog.open('APP').log Syslog::LOG_INFO, "#{app_name_here} - your message here."
    # Error level
    Syslog.open('APP').log Syslog::LOG_ERR, "ERROR #{app_name_here} - your message here."
```
The Syslog level (```Syslog::LOG_INFO``` or ```Syslog::LOG_ERR```) determines whether the message will actually be logged in the system log.
For example, in Mac OS X, the default is to not log LOG_INFO messages at all.

## Formatting and logwatch detail level

Messages logged using the python class will be logged in this format:

    <syslog timestamp> APP[app name]: Message here

Messages logged using the log_error method will be logged in this format:

    <syslog timestamp> APP[app name]: ERROR Message here

Including "ERROR" as shown in the message output indicates the detail level of the entry to logwatch.
* When logwatch --detail level is Low (\<5) only the ERROR entries will be included in the output.
* When logwatch --detail level is Med (5) or higher, all entries will be included.

