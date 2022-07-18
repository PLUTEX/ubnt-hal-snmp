# SNMP wrapper for Ubiquiti EdgeOS hardware data

Uses the same OIDs as the EdgeSwitch series (and actually most Broadcom-based
switches).

## Installation

1. Copy `ubnt-hal-snmp.sh` to `/config/scripts/` on the router
2. Execute the following commands on the router:

       echo "Debian-snmp ALL = NOPASSWD: /usr/sbin/ubnt-hal" | sudo tee /etc/sudoers.d/02snmp-ubnt-hal
       echo "pass .1.3.6.1.4.1.4413.1.1.43.1 /config/scripts/ubnt-hal-snmp.sh" | sudo tee -a /etc/snmp/snmpd.conf
       sudo systemctl reload snmpd

## Output

The available sensors vary by model. This example is from an ER-8-XG, which
offers the most complete set of sensors:

```
.1.3.6.1.4.1.4413.1.1.43.1.6.1.1.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.1.2.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.6.1.1.3.0 = INTEGER: 3
.1.3.6.1.4.1.4413.1.1.43.1.6.1.2.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.2.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.2.3.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.3.1.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.6.1.3.2.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.6.1.3.3.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.6.1.4.1.0 = INTEGER: 5427
.1.3.6.1.4.1.4413.1.1.43.1.6.1.4.2.0 = INTEGER: 5471
.1.3.6.1.4.1.4413.1.1.43.1.6.1.4.3.0 = INTEGER: 5487
.1.3.6.1.4.1.4413.1.1.43.1.6.1.5.1.0 = INTEGER: 50
.1.3.6.1.4.1.4413.1.1.43.1.6.1.5.2.0 = INTEGER: 50
.1.3.6.1.4.1.4413.1.1.43.1.6.1.5.3.0 = INTEGER: 50
.1.3.6.1.4.1.4413.1.1.43.1.6.1.6.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.6.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.6.1.6.3.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.7.1.1.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.7.1.1.2.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.7.1.2.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.7.1.2.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.7.1.3.1.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.7.1.3.2.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.7.1.4.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.7.1.4.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.1.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.1.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.1.3.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.1.4.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.1.5.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.2.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.2.2.0 = INTEGER: 2
.1.3.6.1.4.1.4413.1.1.43.1.8.1.2.3.0 = INTEGER: 3
.1.3.6.1.4.1.4413.1.1.43.1.8.1.2.4.0 = INTEGER: 4
.1.3.6.1.4.1.4413.1.1.43.1.8.1.2.5.0 = INTEGER: 5
.1.3.6.1.4.1.4413.1.1.43.1.8.1.3.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.3.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.3.3.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.3.4.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.3.5.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.4.1.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.4.2.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.4.3.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.4.4.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.4.5.0 = INTEGER: 1
.1.3.6.1.4.1.4413.1.1.43.1.8.1.5.1.0 = INTEGER: 39
.1.3.6.1.4.1.4413.1.1.43.1.8.1.5.2.0 = INTEGER: 42
.1.3.6.1.4.1.4413.1.1.43.1.8.1.5.3.0 = INTEGER: 68
.1.3.6.1.4.1.4413.1.1.43.1.8.1.5.4.0 = INTEGER: 62
.1.3.6.1.4.1.4413.1.1.43.1.8.1.5.5.0 = INTEGER: 58
```

## Caching

The output of all `ubnt-hal` invocations is cached for one minute, since the
interface between snmpd and the script would otherwise cause one invocation per
OID, which might be insane in case of bulk walks.
