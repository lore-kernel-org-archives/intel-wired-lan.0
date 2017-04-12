From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 12 Apr 2017 16:31:45 +0200
Subject: [Intel-wired-lan] e1000e: Link down after startup on Lenovo X60
Message-ID: <63a45041-39ca-1276-27e2-41d2b6dc7405@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


On a Lenovo X60t, in very rare cases, the link does not get ready with 
Linux 4.11-rc6, and also versions before it.

```
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet 
Controller
```

`ip a` shows that the link is down, and unplugging and plugging the 
network cable back in does not help.

```
$ journalctl -k -o short-precise | grep -i e1000e
Apr 11 23:07:48.553259 x60 kernel: e1000e: Intel(R) PRO/1000 Network 
Driver - 3.2.6-k
Apr 11 23:07:48.553319 x60 kernel: e1000e: Copyright(c) 1999 - 2015 
Intel Corporation.
Apr 11 23:07:48.553499 x60 kernel: e1000e 0000:01:00.0: Interrupt 
Throttling Rate (ints/sec) set to dynamic conservative mode
Apr 11 23:07:48.577368 x60 kernel: e1000e 0000:01:00.0 eth0: (PCI 
Express:2.5GT/s:Width x1) 00:16:d3:b8:e3:49
Apr 11 23:07:48.577529 x60 kernel: e1000e 0000:01:00.0 eth0: Intel(R) 
PRO/1000 Network Connection
Apr 11 23:07:48.577688 x60 kernel: e1000e 0000:01:00.0 eth0: MAC: 2, 
PHY: 2, PBA No: 005302-003
Apr 11 23:07:48.923514 x60 kernel: e1000e 0000:01:00.0 eth8: renamed 
from eth0
```

Removing the module *e1000e* and loading it again fixes the issue.

```
Apr 11 23:12:01.526318 x60 kernel: e1000e 0000:01:00.0: Disabling ASPM 
L0s L1
Apr 11 23:12:01.687420 x60 kernel: e1000e: eth8 NIC Link is Down
Apr 11 23:12:08.295555 x60 kernel: e1000e: Intel(R) PRO/1000 Network 
Driver - 3.2.6-k
Apr 11 23:12:08.295737 x60 kernel: e1000e: Copyright(c) 1999 - 2015 
Intel Corporation.
Apr 11 23:12:08.296006 x60 kernel: e1000e 0000:01:00.0: Interrupt 
Throttling Rate (ints/sec) set to dynamic conservative mode
Apr 11 23:12:08.421070 x60 kernel: e1000e 0000:01:00.0 eth0: (PCI 
Express:2.5GT/s:Width x1) 00:16:d3:b8:e3:49
Apr 11 23:12:08.421389 x60 kernel: e1000e 0000:01:00.0 eth0: Intel(R) 
PRO/1000 Network Connection
Apr 11 23:12:08.421642 x60 kernel: e1000e 0000:01:00.0 eth0: MAC: 2, 
PHY: 2, PBA No: 005302-003
Apr 11 23:12:08.423534 x60 kernel: e1000e 0000:01:00.0 eth8: renamed 
from eth0
Apr 11 23:12:11.609873 x60 kernel: e1000e: eth8 NIC Link is Up 1000 Mbps 
Full Duplex, Flow Control: Rx/Tx
```

Do you know, if that is a known problem? What other information should 
be added to a bug report?


Kind regards,

Paul
