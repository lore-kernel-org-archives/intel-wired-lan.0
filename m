From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 14 Mar 2018 12:58:28 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v4 6/8] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C8032A0@ORSMSX101.amr.corp.intel.com>
References: <20180308003713.29195-1-vinicius.gomes@intel.com>
 <20180308003713.29195-7-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C8032A0@ORSMSX101.amr.corp.intel.com>
Message-ID: <87605ywhsr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>> Behalf Of Vinicius Costa Gomes
>> Sent: Wednesday, March 7, 2018 4:37 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
>> palencia at intel.com>
>> Subject: [Intel-wired-lan] [next-queue PATCH v4 6/8] igb: Add MAC address
>> support for ethtool nftuple filters
>> 
>> This adds the capability of configuring the queue steering of arriving
>> packets based on their source and destination MAC addresses.
>> 
>> In practical terms this adds support for the following use cases,
>> characterized by these examples:
>> 
>> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
>> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
>> to the RX queue 0)
>> 
>> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
>> (this will direct packets with source address "44:44:44:44:44:44" to
>> the RX queue 3)
>
> This seems to work fine on i210, and the patch series allows me to set
> the rx filters on the i350, i354 and i211, but it is not directing the
> packets to the queue I request.
>

For the i211, it seems that the datasheet is slightly misleading: it has
the QSEL bit documented on the RAH registers, but the queue selection
bits are not mentioned, so it really seems that queue selection won't
work for this controller.

For the other cases (in a quick search I couldn't find the i354
datasheet), the semantics changes, it's more about pool selection than
queue selection, and it depends on vfs_allocated_count (>= 1) and the
number of rss_queues (<= 1) to get to the state where setting the queue
via filters would have the expected effect.

> With the exception of i210 the rx_queues number does not seem to be
> effected by setting the filter. In the case of i211 the rx packets
> stay on rx_queue 0 with or without an ether src or dst filter. The
> first example one seems to work at first since it's directing to queue
> 0, but changing the filter to "action 1" does not change the behavior.
> With the i350 and i354 ports the packets are spread across the
> rx_queues with or without the filter set.
>

So, what I am thinking is: make it an error selecting any queue
different than zero (this is expected to work for all controllers, and
it's what will be called when the user does something like 'ip maddr'),
for controller different than the i210. Later, if/when this feature is
needed for other controllers we can extend the checks.

Does this make sense?


Thanks,
--
Vinicius
