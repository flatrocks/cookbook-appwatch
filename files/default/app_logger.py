import syslog
import os

# python logging to work with appwatcher logwatch service
class AppLogger:

    def __init__(self, app_name):
        self._app_name = app_name
        syslog.openlog(ident="APP[{0}]".format(os.getpid()))

    def log_info(self, message):
        syslog.syslog(syslog.LOG_INFO, "{0} - {1}".format(_app_name, message))

    def log_error(self, message):
        syslog.syslog(syslog.LOG_ERR, "ERROR {0} - {1}".format(_app_name, message))
