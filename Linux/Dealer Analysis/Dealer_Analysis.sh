#!/bin/bash

grep -i $1 $2_Dealer_schedule | awk -F'\t' '{print $1, $3}'
