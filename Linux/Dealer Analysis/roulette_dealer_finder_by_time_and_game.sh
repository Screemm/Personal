#!/bin/bash

if [ $1 == '' ]
then
	echo "The first argument must be set. This argument is a time (eg. 08:00:00 AM)."
	echo "Please re-run the script."
elif [ $2 == '' ]
then
        echo "The second argument must be set. This argument is a date denoted as mmdd (eg. 1014 for October 14th)."
	echo "Please re-run the script."
elif [ $3 == '' ]
then
	echo "The third argument must be set. To ensure the script runs correctly, surround the game name with single quote marks (eg. 'Black Jack')."
	echo "Please re-run the script."
elif [ ${3,,} == 'roulette' ]
then
	grep -i $1 $2_Dealer_schedule | awk -F'\t' '{print $1, $3}'
elif [ ${3,,} == 'black jack' ] || [ ${3,,} == 'blackjack' ]
then
	grep -i $1 $2_Dealer_schedule | awk -F'\t' '{print $1, $2}'
elif [ ${3,,} == 'texas hold em' ]
then
    grep -i $1 $2_Dealer_schedule | wk -F'\t' '{print $1, $4}'
else
	echo "Something went wrong."
	echo "Please re-run the script."
fi
