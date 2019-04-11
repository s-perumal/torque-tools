#!/bin/bash
#simple scripts to 
# print the groupwise running jobs for torque pbs
# Sathya S R R Perumal PhD
# 2019 Jan 1

if [ qstat  ];
then

echo "#Status #Jobid #Nodes #Cores #Username #Groupname"


qstat -f | grep -wE  "euser|egroup|Resource_List.nodes|job_state|Id" | xargs -n15 | sed 's/ppn=//g; s/cpu24a//g; s/hm512g//g; s/:/ /g; s/nvidia//g ; s/.tuemn1//g' | awk '$6== "R" { printf "%-2s %-10s %-4s %-4s  %-10s %-15s\n", $6,$3,$9,$9*$10,$13,$16  }' | sort  -k6 > groupwise.txt



cat groupwise.txt

echo "#GroupName #No_nodes"

cat groupwise.txt | awk '{a[$6] +=$3} END{for (i in a) print i,a[i] }'  | sort -u -k1

#this is optional to remove groupwise file after the print
#rm -rf groupwise.txt



fi

exit
