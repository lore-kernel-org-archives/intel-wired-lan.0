From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 27 Mar 2018 01:40:57 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <87lgeecryc.fsf@intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
 <20180322003353.29970-8-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C81BBB3@ORSMSX101.amr.corp.intel.com>
 <87lgeecryc.fsf@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C81CD24@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Gomes, Vinicius
> Sent: Monday, March 26, 2018 4:56 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC
> address support for ethtool nftuple filters
> 
> Hi Aaron,
> 
> "Brown, Aaron F" <aaron.f.brown@intel.com> writes:
> 
> >
> > Maybe not "this" patch, but this is the one that enables the ethtool
> commands, so replying here.
> > The filters do not seem to take effect with this version (v5) of the
> > series.  The commands are accepted for i210 and rejected with
> > unsupported messages for the other adapters (as desired) and an
> > ethtool -n shows the filter, however, with either the src or dst
> > filter set I can run traffic (netperf) that should be caught by the
> > filter and rather than being directed to the single queue it is spread
> > across queues as would be expected without the filter set.
> >
> > The test system still has a kernel / driver with the v4 series of this
> > patch set and the exact same filter commands / system setup does
> > filter the traffic to the specified rx queue with the v4 series.
> 
> That's interesting. The only difference is that now non steering filters
> (filters added by 'ip (m)addr', PACKET_ADD_MEMBERSHIP and the local MAC
> address, for example) do not have the QSEL bit set.
> 
> On my tests I cannot detect any change in behaviour between those two
> versions of the series, for example. trying to add a filter for the
> local MAC address has no visible effect in both versions. (This raises a
> question: should this be an error, or should this override the default
> entry configuration, or this behaviour is fine?)
> 
> Can you share more information about your tests? so I can reproduce it here.

Sure, on I'm running a system the i210 is eth3 and it is linked back to back (crossover cable) to a link partner.  The i210 has a mac address of a0:36:9f:10:cc:d7 and the MAC address of the port it is connected to is 00:1b:21:60:29:ea.  It should not matter, but eth0 is an older e1000 based adapter (82540EM) I use for connecting ssh sessions, eth1 and eth2 are other igb ports (a dual port 82575EB adapter.)

I tried both an ethtool src and ethtool dst filter with these addresses and with the older version they both seemed to work and with the latest patch in place neither seemed to work.  My steps were to set the filter, check that ethtool shows the filter in place then run some netperf traffic (using a script we have called netperf_stress that cycles through a number of sessions to provide constant traffic) and from another login session I watched the rx_queue counters.

For the src filter I used the MAC address of the link partner eth3 interface, 00:1b:21:60:29:ea :
-----------------------------------------------------------------------------
u1485:[0]/root> ethtool -N eth3 flow-type ether src 00:1b:21:60:29:ea action 0
Added rule with ID 15
u1485:[0]/root> ethtool -n eth3
4 RX rings available
Total 1 rules

Filter: 15
        Flow Type: Raw Ethernet
        Src MAC addr: 00:1B:21:60:29:EA mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to VF 0 queue 0

u1485:[0]/root>netperf_stress u0485-3
Test limit is NONE
Found netperf support
u0485:[0]/root

Contacted u0485-3

---------> Testing with u0485-3 - Testing since Mon Mar 26 17:35:32 PDT 2018
...
...
-----------------------------------------------------------------------------
Then on another login I watch on an ethtool stat dump grepping for rx_queue.  I threw a -d to get a better visual of the differences.

-----------------------------------------------------------------------------
1485:[1]/root> watch -d 'ethtool -S eth3|grep rx_queue'
Every 2.0s: ethtool -S eth3|grep rx_queue               Mon Mar 26 18:19:21 2018

     rx_queue_0_packets: 13
     rx_queue_0_bytes: 2204
     rx_queue_0_drops: 0
     rx_queue_0_csum_err: 0
     rx_queue_0_alloc_failed: 0
     rx_queue_1_packets: 330677
     rx_queue_1_bytes: 500632203
     rx_queue_1_drops: 0
     rx_queue_1_csum_err: 0
     rx_queue_1_alloc_failed: 0
     rx_queue_2_packets: 141902
     rx_queue_2_bytes: 214787953
     rx_queue_2_drops: 0
     rx_queue_2_csum_err: 0
     rx_queue_2_alloc_failed: 0
     rx_queue_3_packets: 234377
     rx_queue_3_bytes: 347172517
     rx_queue_3_drops: 0
     rx_queue_3_csum_err: 0
     rx_queue_3_alloc_failed: 0
-----------------------------------------------------------------------------
After a few moments I can tell the counters are all over the place.  I do pretty much the exact same thing for the dst filter, except I use the i210's MAC address for the destination instead of the one on the link partner:
-----------------------------------------------------------------------------
u1485:[1]/root> ethtool -N eth3 delete 15
u1485:[1]/root> ethtool -N eth3 flow-type ether dst a0:36:9f:10:cc:d7  action 0
Added rule with ID 15
u1485:[1]/root> ethtool -n eth3
4 RX rings available
Total 1 rules

Filter: 15
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: A0:36:9F:10:CC:D7 mask: 00:00:00:00:00:00
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to VF 0 queue 0

u1485:[1]/root> netperf_stress u0485-3
Test limit is NONE
Found netperf support
u0485:[0]/root

Contacted u0485-3

---------> Testing with u0485-3 - Testing since Mon Mar 26 17:35:32 PDT 2018
...
...
-----------------------------------------------------------------------------
And watching the rx_queue counters continues to be spread across the different queues.  This is with Jeff Kirsher's  next queue, kernel 4.16.0-rc4_next-queue_dev-queue_e31d20a, which has the series of 8 igb patches applied.

When I go back and run the an older build (with an earlier version of the series) of the same tree, 4.16.0-rc4_next-queue_dev-queue_84a3942, with the same procedure and same systems all the rx traffic is relegated to queue 0 (or whichever queue I assign it to) for either the src or dst filter.  Here is a sample of my counters after it had been running netperf_stress over the weekend:
-----------------------------------------------------------------------------1485:[1]/root> watch -d 'ethtool -S eth3|grep rx_queue'
Every 2.0s: ethtool -S eth3|grep rx_queue               Mon Mar 26 17:37:44 2018

     rx_queue_0_packets: 16453268766
     rx_queue_0_bytes: 23420384893393
     rx_queue_0_drops: 0
     rx_queue_0_csum_err: 0
     rx_queue_0_alloc_failed: 0
     rx_queue_1_packets: 0
     rx_queue_1_bytes: 0
     rx_queue_1_drops: 0
     rx_queue_1_csum_err: 0
     rx_queue_1_alloc_failed: 0
     rx_queue_2_packets: 0
     rx_queue_2_bytes: 0
     rx_queue_2_drops: 0
     rx_queue_2_csum_err: 0
     rx_queue_2_alloc_failed: 0
     rx_queue_3_packets: 0
     rx_queue_3_bytes: 0
     rx_queue_3_drops: 0
     rx_queue_3_csum_err: 0
     rx_queue_3_alloc_failed: 0

> 
> 
> Thank you,
> --
> Vinicius
