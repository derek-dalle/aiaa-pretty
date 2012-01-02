#!/bin/bash

# This script prepares a release candidate for the aiaa-pretty template.  It
# creates a# ZIP archive because that is a format that is easily opened on a 
# wide variety of operating systems.  It will create an archive that is in the
# folder  
#
#  release/
# 
# and has a name that corresponds to the first argument of this function.
#
# The release contains all of the files in the folder
#
#  sample/
#
# in addition to the file
#
#  aiaa-pretty.cls
#
# which contains the actual source of this package.
#
# This script must be run from the aiaa-pretty folder that contains the .git
# folder because the script contains relative file references.

# This will create the archive with a name based on the first input.
zip release/${1%.zip}.zip aiaa-pretty.cls -r sample/

