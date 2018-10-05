From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 5 Oct 2018 17:35:29 +0200
Subject: [Intel-wired-lan] Periodic jumps of PHC on I350
Message-ID: <20181005153529.GK19804@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'm observing a weird issue with the PTP clock on the I350. Every ~9.2
minutes (which coincides with a half of the 40-bit SYSTIM overflow) it
jumps about 1100 seconds back and then 8 seconds later it jumps ahead
to where it was supposed to be.

From ptp4l output:

ptp4l[1700.796]: master offset        126 s2 freq  -14982 path delay     45720
ptp4l[1701.796]: clockcheck: clock jumped backward or running slower than expected!
ptp4l[1701.796]: master offset -1099511626698 s0 freq  -14982 path delay     45720
ptp4l[1701.796]: port 1: SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
ptp4l[1702.796]: master offset -1099511626796 s0 freq  -14982 path delay     45720
ptp4l[1703.796]: master offset -1099511621597 s0 freq  -14982 path delay     45664
ptp4l[1704.796]: master offset -1099511625711 s2 freq -62499999 path delay     45720
ptp4l[1704.796]: port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
ptp4l[1705.796]: master offset -1099449150078 s2 freq -62499999 path delay     45902
ptp4l[1706.796]: master offset -1099386663207 s2 freq -62499999 path delay     45561
ptp4l[1707.796]: master offset -1099324177805 s2 freq -62499999 path delay     45561
ptp4l[1708.796]: master offset -1099261696997 s2 freq -62499999 path delay     45256
ptp4l[1709.796]: clockcheck: clock jumped forward or running faster than expected!
ptp4l[1709.796]: master offset  312422909 s0 freq -62499999 path delay     45256

I see it on four different machines (three have I350, one I354). I've
tried 4.19-rc6 and few different versions down to 4.13. All show this
behavior.

Any ideas what could be wrong?

-- 
Miroslav Lichvar
