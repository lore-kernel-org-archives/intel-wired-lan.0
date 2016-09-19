From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Date: Mon, 19 Sep 2016 17:09:18 +0300
Subject: [Intel-wired-lan] [igb] Wake on LAN for suspend-to-idle broken
	after suspend to ram.
Message-ID: <992cbfca-62fe-0e86-c058-1160eeee70ca@dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[igb] Wake on LAN for suspend-to-idle broken after suspend to ram.

System cannot be woken up from suspend-to-iddle (S0 state) using
Wake on LAN (WoL) feature if previously system was woken up from
suspend to ram (S3 state) using WoL feature. Problem can be observed
with igb ethernet driver with i210/i211 ethernet controllers.

How to reproduce:
  - Turn system to S3 state:
    echo mem > /sys/power/state
  - wakeup system using WoL magick packet;
  - Turn system to S0 state:
    echo freeze > /sys/power/state
  - Try to wakeup system using WoL magick packet;
  - Fails to wake up from S0 state.

But we have found that a wake up counter changes after sending a magick 
packet from host:
# cat /sys/class/net/eth0/device/power/wakeup_count
2

The issue can be reproduced with different boards with i210/i211
ethernet controller with different BIOSes (from different vendors),
with different kernels (4.4-4.7). Also cannot be reproduced with i219 
controller
with e1000e driver.

But it cannot be reproduced if system is woken up from S3 using Power 
button or USB, e.g.:
  - Turn system to S3 state:
    echo mem > /sys/power/state
  - wakeup system using USB keyboard;
  - Turn system to S0 state:
    echo freeze > /sys/power/state
  - Try to wakeup system using WoL magick packet;
  - System wakes up from S0 state.
Plus the problem cannot be reproduced with i219.

We believe that the problem is related to intel igb driver which fails 
to wake up system
from S0 state.

System information:
Linux 4.4.13-yocto #1 SMP PREEMPT Tue Sep 13 12:48:47 MSK 2016 x86_64 
x86_64 x86_64 GNU/Linux
Distro: custom Yocto 2.1
Ethernet controller: Intel Corporation I211 Gigabit Network Connection 
(rev 03)

Please tell if additional information/experiments are needed.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.log
Type: text/x-log
Size: 55428 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160919/cc35116c/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.log
Type: text/x-log
Size: 1562 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160919/cc35116c/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: wakeup_sources.log
Type: text/x-log
Size: 1259 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160919/cc35116c/attachment-0005.bin>
