import os
import subprocess

from ranger.api.commands import Command


class kdeconnect_send(Command):
    """:kdeconnect_send

    Send selected files to a device using kdeconnect-cli.
    Skips any selected directories.

    """

    def execute(self):
        # Get device id
        id = subprocess.run(
            ["kdeconnect-cli", "-a", "--id-only", "|", "awk", "'{printf $1}'"],
            capture_output=True,
            encoding="utf-8",
        ).stdout.rstrip("\n")

        # Exit if no connected device
        if id == "":
            self.fm.notify("No device found", bad=True)
            return

        # Get paths of selected files
        paths = []
        for file in self.fm.thisdir.get_selection():
            path = file.basename
            if os.path.isfile(path):
                paths.append("'" + path + "'")

        paths = " ".join(paths)

        # Share files
        command = f"kdeconnect-cli -d {id} --share {paths}"
        self.fm.notify(f"Sending {paths} to device {id}")
        self.fm.execute_command(command)

        # Unmark files when done
        self.fm.thisdir.mark_all(False)
