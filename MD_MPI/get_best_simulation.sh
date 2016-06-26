#!/bin/bash

echo "going to get best simulation for ETH"

for dataset in 1 3 
do
  for ppn in 1 2 4  8  10 12 14 16 22 24 26 28 30 32 34 36 38 64 96 128
  do
   grep -E "[0-9]+[.][0-9]+" "time_eth/"$dataset"/ppn_"$ppn".txt" | sort | head -n 1  > "time_eth/"$dataset"/best_"$ppn".csv"
  done
done

echo "going to get best simulation for MYRI"

for dataset in 1 3 
do
  for ppn in 1 2 4  8  10 12 14 16 22 24 26 28 30 32 
  do
    sort "time_myri/"$dataset"/ppn_"$ppn".txt" | head -n 1 > "time_myri/"$dataset"/best_"$ppn".csv"
  done
done

