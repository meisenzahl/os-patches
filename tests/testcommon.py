"""Common testing stuff"""

import apt_pkg
import os

import sys
import unittest


class TestCase(unittest.TestCase):
    """Base class for python-apt unittests"""

    def setUp(self):
        self.resetConfig()

    def resetConfig(self):
        apt_pkg.config.clear("")
        for key in apt_pkg.config.list():
            apt_pkg.config.clear(key)

        # Avoid loading any host config files
        os.unsetenv("APT_CONFIG")
        apt_pkg.config["Dir::Etc::main"] = "/dev/null"
        apt_pkg.config["Dir::Etc::parts"] = "/dev/null"

        apt_pkg.init_config()
        apt_pkg.init_system()

        # Restore default values
        apt_pkg.config["Dir::Etc::main"] = "apt.conf"
        apt_pkg.config["Dir::Etc::parts"] = "apt.conf.d"

    if (sys.version_info.major, sys.version_info.minor) < (3, 2):
        def assertRaisesRegex(self, exc_typ, regex, func, *args, **kwds):
            """Compatibility helper"""
            try:
                func(*args, **kwds)
            except Exception as exc:
                self.assertIsInstance(exc, exc_typ)
                self.assertRegexpMatches(str(exc), regex)
            else:
                self.fail("Did not raise exception")
