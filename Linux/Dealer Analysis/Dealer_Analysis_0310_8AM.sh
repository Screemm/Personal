#!/bin/bash

grep -i '08:00:00 AM' 0310_Dealer_schedule | awk -F'\t' '{print $1, $3}' >> Dealers_working_during_losses
