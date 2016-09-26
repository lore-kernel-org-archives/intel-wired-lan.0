From: Kurien Mathew <kurien.mathew@ericsson.com>
Date: Mon, 26 Sep 2016 09:53:01 +0000
Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode
In-Reply-To: <22B3FA801D86A143A7D448636913BBD2C2BE57@ESESSMB107.ericsson.se>
References: <22B3FA801D86A143A7D448636913BBD2C2BB52@ESESSMB107.ericsson.se>
 <87618083B2453E4A8714035B62D67992506E7B4C@FMSMSX105.amr.corp.intel.com>
 <22B3FA801D86A143A7D448636913BBD2C2BDC0@ESESSMB107.ericsson.se>
 <87618083B2453E4A8714035B62D67992506E7C09@FMSMSX105.amr.corp.intel.com>
 <22B3FA801D86A143A7D448636913BBD2C2BE57@ESESSMB107.ericsson.se>
Message-ID: <22B3FA801D86A143A7D448636913BBD2C2C7FC@ESESSMB107.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Would it be possible to support the IP header field "identification" as an option for rx-flow-hash? I could not find this option in ethtool.

Kurien

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Kurien Mathew
Sent: 23 September 2016 21:23
To: Tantilov, Emil S; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode


>>This will enable RSS for UDP, but I'm not sure what you mean by "automatic perfect filtering".

Yes, RSS for UDP along with precise distribution of packets to queues is what I want. Eg if I have 16 UDP streams coming in I want each to go to a different RX queue based on the "sdfn" hash (resulting in 16 active RSS queues). The benefit of the "sdfn" hash is that it is automatic as opposed to explicit rules which don't work when the application defined ports change dynamically.



>>Probably due to fragmented UDP packets.

Good point. I forgot to mention that the UDP flows use jumbo packets. This could explain why some packets escape the filter and go into a default queue. Do you have suggestions on how to handle this case using rx-flow-hash? Can the ip.id field be used for the hash in order to achieve perfect jumbo UDP filtering?



Kurien



-----Original Message-----
From: Tantilov, Emil S [mailto:emil.s.tantilov at intel.com]
Sent: 23 September 2016 20:03
To: Kurien Mathew; intel-wired-lan at lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>
Subject: RE: ixgbe FdirMode for Perfect filter mode



>-----Original Message-----

>From: Kurien Mathew [mailto:kurien.mathew at ericsson.com]

>Sent: Friday, September 23, 2016 9:25 AM

>To: Tantilov, Emil S <emil.s.tantilov at intel.com<mailto:emil.s.tantilov@intel.com>>; intel-wired-

>lan at lists.osuosl.org<mailto:lan@lists.osuosl.org>

>Subject: RE: ixgbe FdirMode for Perfect filter mode

>

>I see commands for enabling fdir (flow director) and adding filters but

>no way to enable "perfect filter" mode instead of the "ATR" mode which

>is mentioned as the default director mode.

>

>Other ethtool Commands:

>

>To enable Flow Director

>

>                ethtool -K ethX ntuple on



This will enable "perfect filter" mode, but there are no filters yet, so the received packets will fall back to RSS.



>

>To add a filter

>

>                Use -U switch. e.g., ethtool -U ethX flow-type tcp4

>src-ip

>10.0.128.23

>

>        action 1

>

>To see the list of filters currently present:

>

>                ethtool -u ethX

>

>

>

>I would like to have balanced queues by having automatic perfect

>filtering when using "rx-flow-hash udp sfdn".



This will enable RSS for UDP, but I'm not sure what you mean by "automatic perfect filtering".



>[root at ace ~]# ethtool -u ens802f1 rx-flow-hash udp4

>

>UDP over IPV4 flows use these fields for computing Hash flow key:

>

>IP SA

>

>IP DA

>

>L4 bytes 0 & 1 [TCP/UDP src port]

>

>L4 bytes 2 & 3 [TCP/UDP dst port]

>

>

>

>Currently I find that one or a few queues are populated irrespective of

>the number of unique UDP streams (in my case it is 16). If I use

>explicit rules using < flow-type udp4 dst-port <xxxxx> action <n>, all

>specified queues are populated but one queue remains dominant and receives way more packets.



Probably due to fragmented UDP packets.



Thanks,

Emil


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160926/b50eef1f/attachment.html>
