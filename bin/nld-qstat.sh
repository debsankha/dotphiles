#!/bin/bash
watch -n 1 'qstat -g c -q frigg.q,skadi.q,navier.q,fulla.q; echo; echo "`qstat -s r | grep $USER | wc -l` running, `qstat -s p | grep $USER | wc -l` pending, `qstat | grep $USER | wc -l` total jobs"; echo; qstat'
