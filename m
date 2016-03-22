From: Murali Mohan <muralidasmohan@hotmail.com>
Date: Tue, 22 Mar 2016 20:32:31 +0530
Subject: [Intel-wired-lan] [e1000:bugs] #515 Intermittent IPV4 Tx packet
 drops seen with e1000e after Linux kernel upgrade
In-Reply-To: </p/e1000/bugs/515/81f01c82eb92e909bfd5acb8a12787b56abd2e3a.bugs@e1000.p.sourceforge.net>
References: <56eb02dbea406b289377782f.bugs@e1000.p.sourceforge.net>,
 </p/e1000/bugs/515/81f01c82eb92e909bfd5acb8a12787b56abd2e3a.bugs@e1000.p.sourceforge.net>
Message-ID: <BLU181-W3906A51152BAF3EBB7901FD2800@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Can someone help us to analyze this packet drop issue seen with newer e1000e driver?

Thanks 
Murali





 [bugs:#515] Intermittent IPV4 Tx packet drops seen with e1000e after Linux kernel upgrade

Status: open

Created: Thu Mar 17, 2016 07:17 PM UTC by Murali Mohan

Last Updated: Thu Mar 17, 2016 07:17 PM UTC

Owner: nobody

Attachments:


kernel_3.12.txt (9.7 kB; text/plain)
kernel_3.16.7ckt11.txt (9.9 kB; text/plain)

Linux kernel 3.16.7ckt11, x86_64, e1000e driver version 2.3.2-k.

Test Set-up

           +----+                         +----+    
           | M1 |-------(switch)----------| M2 |
           +----+                         +----+



M1/M2 are Debian systems connected to an ethernet switch through a 1gbps link. 

We recently upgraded the linux Kernel of M1 to 3.16.7ckt11.

M2 does netboot from M1. At times we see that the netboot is taking more than 10 minutes (which normally takes 1-2 

minutes). 

On debugging this further we saw lot of tftp retransmissions on M1. From a packet capture on the switch using mirroring feature, only one copy of the retrasnmitted packet was seen at the switch, confirming that the drop was in M1 itself.

The dropped packet was seen in tcpdump and iptable OUTPUT chains on M1. 

None of the error counters in Kernel or NIC (ethtool -S) registers this drop.

Further debugging using ftrace, we saw that tx code flow (udp_sendmsg) was hitting the driver transmit code (e1000_xmit_frame) for all packets.  No error conditions in e1000_xmit are hit (confirmed by adding trace_printk).

Issue is not consistent, seen randomly after system reboot of M1.

Work arounds:

Issue is cleared by:

->hard reset of M1 or 

->reloading the e1000e driver on M1 (rmmod e1000e.ko followed by insmod e1000e.ko)

Old kernel was 3.12, which also had same driver version (2.3.2-k), but has many differences in code when compared to 3.16 source tree.

We tried re-building the driver code in 3.12 source tree, for 3.16.7 kernel, and with this driver, issue is not seen.

NIC details:

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)

Driver details:

ethtool -i eth0
driver: e1000e

version: 2.3.2-k

firmware-version: 0.15-4

bus-info: 0000:00:19.0

supports-statistics: yes

supports-test: yes

supports-eeprom-access: yes

supports-register-dump: yes

supports-priv-flags: no

Issue was also seen with latest driver, version 3.3.3.

Attachment has details of driver and registers collected with old kernel and new kernel.

Kindly help to solve this issue. 


Sent from sourceforge.net because you indicated interest in https://sourceforge.net/p/e1000/bugs/515/

To unsubscribe from further messages, please visit https://sourceforge.net/auth/subscriptions/
 		 	   		  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160322/891d4b14/attachment.html>
