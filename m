From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Tue, 2 Jun 2015 00:47:11 +0000
Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when
 in	promiscuous mode
In-Reply-To: <556CF268.2060703@windriver.com>
References: <5568D344.9090903@windriver.com>
 <C5551D9AAB213A418B7FD5E4A6F30A078930269A@ORSMSX108.amr.corp.intel.com>
 <556CF268.2060703@windriver.com>
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EBFFBA@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Subject: Re: [Intel-wired-lan] vlan packet handling in ixgbevf driver when in promiscuous mode
> 
> Could you elaborate?
> 
> The use-case here is for NFV/SDN type stuff, where we want to be able to run a
> router or something similar in the guest--so it needs to be able to receive
> packets from all VLANs.
> 
>  From what I see if you enable promiscuous mode on the PF then the VFs get
> packets from all VLANs.

I'd like to have and am working to add a functionality to disable VLAN filter on PF
to pass all VLANs to VFs in stock kernel ixgbe driver.
How did you do that?

> 
> With the stock ixgbevf driver in the guest this doesn't work well because any
> packets from VLANs that the guest hasn't registered for do not get the vlan tags
> added back in to the packets (which makes it useless for routing).  With a minor
> change to the ixgbevf driver to put the vlan tags back in for all packets it
> seems to work okay.  Maybe this change would be a reasonable thing to do in the
> stock ixgbevf driver when enabling promiscuous mode in the guest?

I just have confirmed that behavior during my work, and thought something to do to
fix this issue.

Currently ixgbevf driver relies on VLAN filtering, that leads to this issue.

Dropping unregistered VLAN packet is expected behavior, I think.
I'm not sure whether we should implement to capture unknown VLAN packet in VF.

What do you think?

thanks,
Hiroshi

> 
> Also, it seems to work fine with the DPDK drivers in the guest when the host is
> in promiscuous mode.
> 
> Chris
> 
> On 06/01/2015 10:48 AM, Rose, Gregory V wrote:
> > 82599 devices do not support promiscuous mode for the virtual functions - you should use the physical function for true
> promiscuous capture.
> >
> > ----------
> > Greg Rose
> > FreeBSD/NFV PAE
> > Network Division
> > Intel Corporation
> > Desk - 503-712-5048
> >
> > Any man who afflicts the human race with ideas must be prepared to see them misunderstood.
> >
> > - H. L. Mencken
> >
> >> -----Original Message-----
> >> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> >> Behalf Of Chris Friesen
> >> Sent: Friday, May 29, 2015 2:00 PM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when in
> >> promiscuous mode
> >>
> >> Hi,
> >>
> >> I'm doing some work with ixgbevf in the 3.10 kernel, but the current linux
> >> kernel git version seems to have similar behaviour.
> >>
> >> Basically I'm interested in doing packet sniffing in a VM guest using PCI
> >> passthrough of a VF of an 82599.
> >>
> >> What I'm seeing is that if I register for a vlan in the guest (creating
> >> eth1.100, for example) and then run tcpdump on the underlying device
> >> (eth1, for
> >> example) then I see the packet with the vlan header in it.
> >>
> >> If I remove that vlan, then I see the packet with no vlan header.
> >>
> >> I think this is coming from ixgbevf_receive_skb() in 3.10 (or
> >> ixgbevf_process_skb_fields() in current upstream git) where it has code
> >> that looks like this:
> >>
> >> 	if (test_bit(vid & VLAN_VID_MASK, active_vlans))
> >> 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> >>
> >> While this makes sense for normal operation (where traffic from other
> >> vlans isn't coming in anyways) I don't think it makes sense when
> >> promiscuous mode is enabled.
> >>
> >> In promiscuous mode I want to be able to see exactly what packets are
> >> coming on the (virtual) wire, so I should be able to see the vlan header
> >> even if I haven't actually registered for that vlan.
> >>
> >> Basically I think that code above should add an "or device is in
> >> promiscuous mode" clause.
> >>
> >> Thoughts?
> >>
> >> Chris
> >> _______________________________________________
> >> Intel-wired-lan mailing list
> >> Intel-wired-lan at lists.osuosl.org
> >> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
