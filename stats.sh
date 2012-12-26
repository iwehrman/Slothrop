#!/bin/sh

FILE=$1

for i in YES NO MAYBE TIMEOUT; do
    cat $FILE | grep ask | grep $i | awk '{print $2, $4}' > $FILE.$i
#    echo 0 0 >> $FILE.$i
done



GNUPLOT=gnuplot
CMD="set terminal aqua\n"
CMD="$CMD set title \"AProVE times for $FILE\"\n" 
CMD="$CMD set autoscale\n"
CMD="$CMD set xlabel \"Call number\"\n"
CMD="$CMD set ylabel \"Time (s)\"\n"
CMD="$CMD plot "

DIRTY=0
for i in YES NO MAYBE TIMEOUT; do
    if [ "0" != `du $FILE.$i | awk '{print $1}'` ]; then
        if [ 1 -eq $DIRTY ]; then
            CMD="$CMD, "
        fi
        CMD="$CMD \"$FILE.$i\" using 1:2 title '$i' with linespoints"
        case "$i" in
            "YES" ) CMD="$CMD lt 2"
                ;;
            "NO" ) CMD="$CMD lt 1"
                ;;
            "MAYBE" ) CMD="$CMD lt 4"
                ;;
            "TIMEOUT" ) CMD="$CMD lt 3"
                ;;
        esac 
        DIRTY=1
    fi
done

echo -e $CMD
