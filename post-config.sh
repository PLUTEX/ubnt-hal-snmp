#!/bin/sh

set -eu

SUDOERS="/etc/sudoers.d/02ubnt-hal-snmp"
SUDOERS_LINE="Debian-snmp,snmp ALL = NOPASSWD: /usr/sbin/ubnt-hal"
if ! [ -f "$SUDOERS" ] || ! grep -F "$SUDOERS_LINE" "$SUDOERS" > /dev/null; then
    echo "$SUDOERS_LINE" > "$SUDOERS"
    chmod 0440 "$SUDOERS"
fi

SNMPD_CONF="/etc/snmp/snmpd.conf"
SNMPD_LINE="pass .1.3.6.1.4.1.4413.1.1.43.1 /config/scripts/ubnt-hal-snmp.sh"
if ! grep -F "$SNMPD_LINE" "$SNMPD_CONF" > /dev/null; then
    echo "$SNMPD_LINE" >> "$SNMPD_CONF"
    if command -v systemctl > /dev/null 2>&1; then
        systemctl try-reload-or-restart snmpd
    else
        /etc/init.d/snmpd reload
    fi
fi
