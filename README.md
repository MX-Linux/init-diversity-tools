## init-diversity-tools
-----------------------

## Summary
---------------------------------

A collection of software that can configure antiX or any Debian based system to use multiple inits.
This package contains wrapper scripts to detect init systems and control the rc/rcS/reboot/shutdown/poweroff functions under various inits.


## Recommended build instructions
---------------------------------

```
gbp clone https://gitlab.com/init-diversity/general/init-diversity-tools.git && cd init-diversity-tools && gbp buildpackage -uc -us -ui
```

is the recommended method to build this package directly from git.


```
sudo apt install git-buildpackage debhelper build-essential lintian
```

should get you all the software required to build using this method.



