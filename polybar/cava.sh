#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="$HOME/.config/cava/config"

cp $config_file /tmp/polybar_cava_config

echo "
[general]
bars = 10
sensitivity = 1000

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" >> /tmp/polybar_cava_config

# read stdout from cava
cava -p /tmp/polybar_cava_config | while read -r line; do
    echo $line | sed $dict
done

