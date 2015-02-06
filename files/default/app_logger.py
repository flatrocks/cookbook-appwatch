import syslog

# python logging to work with appwatcher logwatch service
class AppLogger:

    def __init__(self, app_name):
        self._app_name = app_name
        syslog.openlog(ident="APP[{0}]".format(app_name))

    def log_info(self, message):
        syslog.syslog(syslog.LOG_INFO, message)

    def log_error(self, message):
        syslog.syslog(syslog.LOG_ERR, "ERROR " + message)
