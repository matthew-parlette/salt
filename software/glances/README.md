Install glances for server monitoring.

This uses `easy_install` to install `pip`, since using the normal `apt-get install pip` would result in `pip` returning `ImportError: cannot import name IncompleteRead`. Installing `pip` through `easy_install` resolved this.

There are some issues with the Ubuntu repository's version of glances (and the psutil dependency), so this state makes sure those packages are absent before installing from pip.
