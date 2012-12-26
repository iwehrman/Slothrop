#!/bin/bash

testdir=$1

for test in $testdir/*tptp
do
    echo "[ START TEST: $test"
    ./solve.sh --debug 3 -t 60 $test 
    echo "STOP TEST: $test ]"
done

