---
title: Mozc UT EDICT2 Dictionary
date: 2023-01-15
---

## Overview

Mozc UT EDICT2 Dictionary is a dictionary converted from [EDICT2](https://www.edrdg.org/wiki/index.php/JMdict-EDICT_Dictionary_Project) for Mozc.

Thanks to EDRDG (Electronic Dictionary Research and Development Group).

## License

mozcdic-ut-edict2.txt: [Creative Commons Attribution-ShareAlike Licence (V4.0)](https://www.edrdg.org/edrdg/licence.html)

Source code: Apache License, Version 2.0

## Usage

Add mozcdic-ut-*.txt to dictionary00.txt and build Mozc as usual.

```
tar xf mozcdic-ut-*.txt.tar.bz2
cat ../mozc-master/src/data/dictionary_oss/dictionary00.txt mozcdic-ut-*.txt > dictionary00.txt.new
mv dictionary00.txt.new ../mozc-master/src/data/dictionary_oss/dictionary00.txt
```

Except for mozcdic-ut-jawiki, the costs are not modified by jawiki-latest-all-titles.

To modify the costs or merge multiple UT dictionaries into one, use the following tool:

[merge-ut-dictionaries](https://github.com/utuhiro78/merge-ut-dictionaries)

## If you create your own UT dictionary

Requirement(s): ruby, rsync

```
cd src/
sh make.sh
```

[HOME](http://linuxplayers.g1.xrea.com/mozc-ut.html)
