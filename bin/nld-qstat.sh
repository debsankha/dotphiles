#!/bin/bash
QUEUES=frigg.q,skadi.q,navier.q,fulla.q

qstat -g c -q $QUEUES
echo
echo 'Running jobs'
qstat -q $QUEUES -u '*' -s r | awk '{print $4}' | sort | uniq -cd | sort -rn
echo
echo 'Queueing jobs'
qstat -q $QUEUES -u '*' -s p | awk '{print $4}' | sort | uniq -cd | sort -rn
echo
echo `qstat -s r | grep $USER | wc -l` running, `qstat -s p | grep $USER | wc -l` pending, `qstat | grep $USER | wc -l` total own jobs
echo
qstat
