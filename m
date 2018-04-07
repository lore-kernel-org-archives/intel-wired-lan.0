From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 7 Apr 2018 02:11:26 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v6 08/10] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <87h8opmt4m.fsf@intel.com>
References: <20180329210751.11531-1-vinicius.gomes@intel.com>
 <20180329210751.11531-9-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C824FA7@ORSMSX101.amr.corp.intel.com>
 <87h8opmt4m.fsf@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C825976@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Gomes, Vinicius
> Sent: Thursday, April 5, 2018 11:00 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: RE: [Intel-wired-lan] [next-queue PATCH v6 08/10] igb: Add MAC
> address support for ethtool nftuple filters
> 
> Hi,
> 
> "Brown, Aaron F" <aaron.f.brown@intel.com> writes:
> 
> >> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> >> Behalf Of Vinicius Costa Gomes
> >> Sent: Thursday, March 29, 2018 2:08 PM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> >> palencia at intel.com>
> >> Subject: [Intel-wired-lan] [next-queue PATCH v6 08/10] igb: Add MAC
> >> address support for ethtool nftuple filters
> >>
> >> This adds the capability of configuring the queue steering of arriving
> >> packets based on their source and destination MAC addresses.
> >>
> >> In practical terms this adds support for the following use cases,
> >> characterized by these examples:
> >>
> >> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
> >> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
> >> to the RX queue 0)
> >
> > This is now working for me, testing with the dst MAC being the MAC on the
> i210.  I set the filter and all the traffic to the destination MAC address gets
> routed to the chosen RX queue.
> >
> >> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
> >> (this will direct packets with source address "44:44:44:44:44:44" to
> >> the RX queue 3)

Since this apparently does not work without refining the filter down to an ethertype I would like to see this example touched up to include the proto keyword.

> >
> > However, I am still not getting the raw ethernet source filter to
> > work.  Even back to back with no other system to "confuse" the stream,
> > I set the filter so the source MAC is the same as the MAC on the link
> > partner, send traffic and the traffic bounces around the queues as if
> > the filter is not set.
> 
> It seems there is at least a documentation issue in the i210 datasheet,
> steering (placing traffic into a specific queue) by source address
> doesn't work, filtering (accepting the traffic based on some rule) does
> work. I pointed this out in the cover letter of v5 as a known issue, but
> forgot to repeat it for v6, sorry about the confusion.

Yes, I recall that now.  I don't think I quite understood the implication at the time, but after trying it out it that makes perfect sense with what I am seeing.

> 
> But only the filtering part is useful, I think, it enables cases like
> this:
> 
> $ ethtool -N enp2s0 flow-type ether src 68:05:ca:4a:c9:73 proto 0x22f0 action
> 3

Ok, yes, this works.  If I tack on the proto keyword I can filter on whatever ethertype I choose and it seems to direct to the queue as expected.

> 
> I added that note in the hope that someone else would have an stronger
> opinion about what to do.

I don't have a strong opinion beyond my preference for an ideal world where everything works :)  If the part simply cannot filter on the src address as a whole without the protocol I would ideally prefer an attempt in ethtool to set the filter on src address as a whole to return an error WHILE still allowing the filter to be set on an ethertype when the proto keyword is issued.  If ethtool does not allow that fine grain of control then I think the way it is now is good, I'd rather have the annoyance of being able to set a filter that does nothing then not be able to set the more specific filter at all.  

> 
> Anyway, my plan for now will be to document this better and turn the
> case that only the source address is specified into an error.
> 
> >
> >>
> >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 35
> >> ++++++++++++++++++++++++----
> >>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> 
> Cheers,
> --
> Vinicius
