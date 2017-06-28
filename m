From: John Steele Scott <toojays@toojays.net>
Date: Wed, 28 Jun 2017 21:51:42 +0930
Subject: [Intel-wired-lan] help to debug "slow" socket reads on ixgbe: numa
 problem? something else?
Message-ID: <3d85b894-dba9-ab43-84f2-5dcae207648b@toojays.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I work on a storage appliance where we recently discovered a performance anomaly between different variants of the same hardware family. One of the current hypotheses about the cause relates to the memory buffers ixgbe allocates to receive data. If we have a userspace app using all the memory on the NUMA node the card is on, can that prevent ixgbe from getting buffers on that node, cause the CPU's DDIO optimization to be bypassed, and thus lead to slow receive performance? Or could a greedy RAID card driver somehow prevent ixgbe from getting its preferred buffers?

Are there statistics we can get from the driver that could prove/disprove this?

What else should we look at?

Background: We noticed that on one of our benchmarks, the larger appliance (more memory, 2 RAID controllers instead of 1, more disk) in a particular product line performed worse than the smaller one. After chopping out most of the data path so we basically just have samba reading data and dropping it on the floor (no disk I/O) we can achieve close enough to line rate (2460M/s) on the small box, but only about 1700M/s on the large box. The large box is using more system cpu + softrq (40%, versus 25% on the small box). Both systems have a dual port X520 connected via socket 1, while the RAID card(s) are through socket 0.

So: less throughput, more CPU usage. Profiling (before we truncated the I/O, but I believe still representative) shows copy_user_enhanced_fast_string() (called from memcpy_toiovec() on the kernel side of a socket read) having a CPI of 36 on the slow box versus 17 on the fast one. Hence the focus on ixgbe's buffers.

Both systems are using dual E5-2609 v3 CPUs. A previous generation of this product line using E5-2609 v2 can hit line rate on both the large and small models. We're currently on a semi-ancient kernel 2.6.32-642 from Centos 6.8.

Thanks in advance for any light you can shed. It might be too late for this product generation but hopefully we can learn something to feed into our next iteration.

Cheers,

John


