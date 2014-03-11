import sys
import subprocess
import json
import os

from asciinema.recorder import Recorder
from asciinema.uploader import Uploader, ServerMaintenanceError, ResourceNotFoundError
from asciinema.confirmator import Confirmator


class RecordCommand(object):

    def __init__(self, api_url, api_token, cmd, title, skip_confirmation,
                 recorder=None, uploader=None, confirmator=None):
        self.api_url = api_url
        self.api_token = api_token
        self.cmd = cmd
        self.title = title
        self.skip_confirmation = skip_confirmation
        self.recorder = recorder if recorder is not None else Recorder()
        self.uploader = uploader if uploader is not None else Uploader()
        self.confirmator = confirmator if confirmator is not None else Confirmator()

    def execute(self):
        asciicast = self._record_asciicast()
        should_upload = self.confirmator.confirm("~ Do you want to upload the recording? [Y/n] ")
        if should_upload:
            self._upload_asciicast(asciicast)
        else:
            print('Yolo?')
            self._save_locally(asciicast)

    def _save_locally(self, asciicast):
        print('Saving locally...')
        print('What should be the name of your recording?')
        record_name = sys.stdin.readline().strip()
        if not os.path.exists(record_name): os.mkdir(record_name)
        save_prefix = record_name + '/' + record_name + '-'
        self._save_files(save_prefix, asciicast)

    def _save_files(self, save_prefix, asciicast):
        data_file = open(save_prefix + 'stdout_data', 'w')
        timing_file = open(save_prefix + 'stdout_timing', 'w')
        meta_data_file = open(save_prefix + 'meta_data.json', 'w')
        data_file.write(asciicast.stdout.data)
        timing_file.write(asciicast.stdout.timing)
        meta_data = asciicast.meta_data
        json.dump(meta_data, meta_data_file)
        data_file.close()
        timing_file.close()
        meta_data_file.close()

    def _record_asciicast(self):
        self._reset_terminal()
        print('~ Asciicast recording started.')

        if not self.cmd:
            print('~ Hit ctrl+d or type "exit" to finish.')

        print('')

        asciicast = self.recorder.record(self.cmd, self.title)

        self._reset_terminal()
        print('~ Asciicast recording finished.')

        return asciicast

    def _upload_asciicast(self, asciicast):
        if self._upload_confirmed():
            print('~ Uploading...')
            try:
                url = self.uploader.upload(self.api_url, self.api_token, asciicast)
                print(url)
            except ServerMaintenanceError:
                print('~ Upload failed: The server is down for maintenance. Try again in a minute.')
                sys.exit(1)
            except ResourceNotFoundError:
                print('~ Upload failed: Your client version is no longer supported. Please upgrade to the latest version.')
                sys.exit(1)

    def _upload_confirmed(self):
        if self.skip_confirmation:
            return True

        return self.confirmator.confirm("~ Do you want to upload it? [Y/n] ")

    def _reset_terminal(self):
        subprocess.call(["reset"])
        pass
