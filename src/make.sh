#!/bin/bash

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

ruby convert_edict2_to_mozcdic.rb
ruby adjust_entries.rb mozcdic-ut-edict2.txt

tar cjf mozcdic-ut-edict2.txt.tar.bz2 mozcdic-ut-edict2.txt
mv mozcdic-ut-edict2.txt* ../

rm -rf ../../mozcdic-ut-edict2-release/
rsync -a ../* ../../mozcdic-ut-edict2-release --exclude=edict2* --exclude=mozcdic-ut-*.txt