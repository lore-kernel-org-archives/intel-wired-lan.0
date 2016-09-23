From: Kurien Mathew <kurien.mathew@ericsson.com>
Date: Fri, 23 Sep 2016 16:25:11 +0000
Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode
In-Reply-To: <87618083B2453E4A8714035B62D67992506E7B4C@FMSMSX105.amr.corp.intel.com>
References: <22B3FA801D86A143A7D448636913BBD2C2BB52@ESESSMB107.ericsson.se>
 <87618083B2453E4A8714035B62D67992506E7B4C@FMSMSX105.amr.corp.intel.com>
Message-ID: <22B3FA801D86A143A7D448636913BBD2C2BDC0@ESESSMB107.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I see commands for enabling fdir (flow director) and adding filters but no way to enable "perfect filter" mode instead of the "ATR" mode which is mentioned as the default director mode.



Other ethtool Commands:

To enable Flow Director

                ethtool -K ethX ntuple on

To add a filter

                Use -U switch. e.g., ethtool -U ethX flow-type tcp4 src-ip 10.0.128.23

        action 1

To see the list of filters currently present:

                ethtool -u ethX



I would like to have balanced queues by having automatic perfect filtering when using "rx-flow-hash udp sfdn".


[root at ace ~]# ethtool -u ens802f1 rx-flow-hash udp4
UDP over IPV4 flows use these fields for computing Hash flow key:
IP SA
IP DA
L4 bytes 0 & 1 [TCP/UDP src port]
L4 bytes 2 & 3 [TCP/UDP dst port]



Currently I find that one or a few queues are populated irrespective of the number of unique UDP streams (in my case it is 16). If I use explicit rules using < flow-type udp4 dst-port <xxxxx> action <n>, all specified queues are populated but one queue remains dominant and receives way more packets.



Kurien





-----Original Message-----
From: Tantilov, Emil S [mailto:emil.s.tantilov at intel.com]
Sent: 23 September 2016 18:01
To: Kurien Mathew; intel-wired-lan at lists.osuosl.org
Subject: RE: ixgbe FdirMode for Perfect filter mode



>-----Original Message-----

>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]

>On Behalf Of Kurien Mathew

>Sent: Friday, September 23, 2016 7:57 AM

To: intel-wired-lan@lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>

>Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode

>

>Hello,

>

>On module ixgbe, I am looking to set option FdirMode

><https://www.kernel.org/doc/Documentation/networking/ixgbe.txt>  to 2

>so as to enable the "Perfect filter" mode. This parameter is not

>reported by "modinfo ixgbe" and using it in /etc/modprobe.d/ixgbe.conf

>causes "modprobe ixgbe" to fail with the message "ixgbe: Unknown

>parameter `FdirMode'" in dmesg.



In the paragraph right above FdirMode (which does not exist anymore btw) there is an example of enabling perfect filters with ethtool.



Thanks,

Emil


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160923/0266ecd5/attachment-0001.html>
