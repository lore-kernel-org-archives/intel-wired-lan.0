From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 18 Jul 2019 21:38:45 +0200
Subject: [Intel-wired-lan] How to update firmware?
Message-ID: <f16c92b9-61bf-6ea8-afc9-28e778c2b625@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


How can I update the firmware of Intel network cards with free software 
utilities? Dell provides a binary to update the firmware, and it worked, 
but I?d like to have the sources. In this case, it was about the device 
below.

```
$ dmesg | grep igb
[?]
[   18.439815] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.4.0-k
[   18.466882] igb: Copyright (c) 2007-2014 Intel Corporation.
[   18.530769] igb 0000:04:00.0: added PHC on eth0
[   18.530772] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network 
Connection
[   18.530773] igb 0000:04:00.0: eth0: (PCIe:5.0Gb/s:Width x2) 
e4:43:4b:13:51:f4
[   18.531091] igb 0000:04:00.0: eth0: PBA No: G61346-018
[   18.531092] igb 0000:04:00.0: Using MSI-X interrupts. 8 rx queue(s), 
8 tx queue(s)
[?]
$ ethtool -i etrh0
driver: ixgbe
version: 5.1.0-k
firmware-version: 0x8000095c, 18.8.9
expansion-rom-version:
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
```


Kind regards,

Paul
