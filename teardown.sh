#!/bin/bash
# (C) Lazula
# Distributed under GPLv3, see LICENSE

for i in $(cat modules.lst); do pactl unload-module $i; done
rm modules.lst
