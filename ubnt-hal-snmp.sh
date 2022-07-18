#!/bin/sh

usage() {
	echo "Usage: $0 (-g | -n) OID"
	exit 1
}

if [ "$1" != "-g" ] && [ "$1" != "-n" ]; then
	usage
elif [ "$#" != 2 ]; then
	usage
fi

OID_PREFIX=".1.3.6.1.4.1.4413.1.1.43.1"
CACHE_FILE="/dev/shm/$(basename "$0").cache"

fan_oid_list() {
	sudo /usr/sbin/ubnt-hal getFanTach | sort | {
		awk -F": " -v prefix="${OID_PREFIX}.6.1" -v idx=1 '{
			sub(/ RPM$/, "", $2)
			print prefix ".1." idx ".0 integer " idx
			print prefix ".2." idx ".0 integer 1"
			print prefix ".3." idx ".0 integer 2"
			print prefix ".4." idx ".0 integer " $2
			print prefix ".5." idx ".0 integer 50"
			print prefix ".6." idx ".0 integer 1"
			idx++
		}'
	}
}

power_oid_list() {
	sudo /usr/sbin/ubnt-hal getPowerSlot | sort | {
		awk -F": " -v prefix="${OID_PREFIX}.7.1" -v idx=1 '$1 ~ / Source$/ {
			print prefix ".1." idx ".0 integer " idx
			print prefix ".2." idx ".0 integer 1"
			if ($2 == "yes")
				print prefix ".3." idx ".0 integer 2"
			else
				print prefix ".3." idx ".0 integer 3"
			print prefix ".4." idx ".0 integer 1"
			idx++
		}'
	}
}

temp_oid_list() {
	sudo /usr/sbin/ubnt-hal getTemp | sort | {
		awk -F: -v prefix="${OID_PREFIX}.8.1" -v idx=1 '$2 != "" {
			sub(/[^0-9].*$/, "", $2)
			print prefix ".1." idx ".0 integer 1"
			print prefix ".2." idx ".0 integer " idx
			print prefix ".3." idx ".0 integer 1"
			print prefix ".4." idx ".0 integer 1"
			print prefix ".5." idx ".0 integer " $2
			idx++
		}'
	}
}

oid_list() {
	fan_oid_list
	power_oid_list
	temp_oid_list
}

cached_oid_list() {
	if ! find "$CACHE_FILE" -mmin +1 -exec false {} + 2> /dev/null; then
		oid_list > "${CACHE_FILE}.$$"
		mv "${CACHE_FILE}.$$" "$CACHE_FILE"
	fi
	cat "$CACHE_FILE"
}

{
	cached_oid_list
	if [ "$1" = "-n" ]; then
		echo "$2 "
	fi
} | sort | if [ "$1" = "-g" ]; then
	grep -F "$2"
elif [ "$1" = "-n" ]; then
	grep -A1 -F "$2 " | grep -vF "$2 "
fi | tr ' ' '\n'
