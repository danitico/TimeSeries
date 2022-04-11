#!/bin/bash

MOA_LIB="/opt/moa/lib/moa.jar"
JAVA_AGENT="/opt/moa/lib/sizeofag-1.0.4.jar"

for seed in {1..30}
do
java -cp $MOA_LIB -javaagent:$JAVA_AGENT moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingTree -s (generators.WaveformGenerator -i $seed) \
    -i 1000000 -f 10000" | cut -d ',' -f5 | tail -n 1 >> hoeffding_online.txt
done
