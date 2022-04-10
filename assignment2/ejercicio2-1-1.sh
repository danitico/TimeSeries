#!/bin/bash

MOA_LIB="/opt/moa/lib/moa.jar"
JAVA_AGENT="/opt/moa/lib/sizeofag-1.0.4.jar"

for seed in {1..10}
do
sum=$(java -cp $MOA_LIB -javaagent:$JAVA_AGENT moa.DoTask \
    "EvaluateModel -m (LearnModel -l trees.HoeffdingTree \
    -s (generators.WaveformGenerator -i $seed) -m 1000000) \
    -s (generators.WaveformGenerator -i 42) -i 1000000" | cut -d ',' -f3 | tail -n+2 | \
    paste -sd+ | bc)
echo "scale=8; $sum/10.0" | bc >> hoeffding_estacionario_offline.txt
done
