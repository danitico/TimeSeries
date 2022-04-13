#!/bin/bash

MOA_LIB="/opt/moa/lib/moa.jar"
JAVA_AGENT="/opt/moa/lib/sizeofag-1.0.4.jar"

for seed in {1..30}
do
java -cp $MOA_LIB -javaagent:$JAVA_AGENT moa.DoTask \
    "EvaluateInterleavedTestThenTrain -l trees.HoeffdingAdaptiveTree \
    -s (generators.RandomRBFGeneratorDrift -i $seed -s 0.001 -k 3 -n 3 -c 2 -a 7) \
    -i 2000000 -f 100000" | cut -d ',' -f5 | tail -n 1 >> hoeffding_adaptativo_online_drift.txt
done
