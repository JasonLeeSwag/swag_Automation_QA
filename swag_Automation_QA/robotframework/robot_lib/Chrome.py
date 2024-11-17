import os
import json


class Chrome(object):

    ROBOT_LIBRARY_VERSION = 1.0

    def __init__(self):
        pass

    def enable_download_in_headless_chrome(self, driver, download_dir):
        """
        there is currently a "feature" in chrome where
        headless does not allow file download: https://bugs.chromium.org/p/chromium/issues/detail?id=696481
        This method is a hacky work-around until the official chromedriver support for this.
        Requires chrome version 62.0.3196.0 or above.
        """

        # add missing support for chrome "send_command"  to selenium webdriver
        driver.command_executor._commands['send_command'] = (
            'POST', '/session/$sessionId/chromium/send_command')

        params = { 'cmd': 'Page.setDownloadBehavior',
                   'params': {  'behavior': 'allow', 'downloadPath': download_dir }
        }
        command_result = driver.execute( 'send_command', params )
        print('response from browser:')
        for key in command_result:
            print('result:' + key + ':' + str(command_result[key]))

    def get_performance_log(self, driver, log_path, filename='log'):
        log_path = log_path + os.sep + filename + '.json'
        logs = []
        log_method = ['Network.requestWillBeSent', 'Network.responseReceived']
        for entry in driver.get_log('performance'):
            if any(method in entry['message'] for method in log_method):
                entry['message'] = json.loads(entry['message'])
                logs.append(json.dumps(entry))

        with open(log_path, 'w') as log_file:
            log_file.write('[' + ','.join(logs) + ']')

        print('Done')
