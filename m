From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Thu, 4 Jun 2015 15:54:20 +0000
Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when
 in	promiscuous mode
In-Reply-To: <556CF268.2060703@windriver.com>
References: <5568D344.9090903@windriver.com>
 <C5551D9AAB213A418B7FD5E4A6F30A078930269A@ORSMSX108.amr.corp.intel.com>
 <556CF268.2060703@windriver.com>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A0789304FA1@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Chris Friesen [mailto:chris.friesen at windriver.com]
> Sent: Monday, June 01, 2015 5:02 PM
> To: Rose, Gregory V; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] vlan packet handling in ixgbevf driver when
> in promiscuous mode
> 
> Could you elaborate?
> 
> The use-case here is for NFV/SDN type stuff, where we want to be able to
> run a router or something similar in the guest--so it needs to be able to
> receive packets from all VLANs.
> 
>  From what I see if you enable promiscuous mode on the PF then the VFs get
> packets from all VLANs.
> 
> With the stock ixgbevf driver in the guest this doesn't work well because
> any packets from VLANs that the guest hasn't registered for do not get the
> vlan tags added back in to the packets (which makes it useless for
> routing).  With a minor change to the ixgbevf driver to put the vlan tags
> back in for all packets it seems to work okay.  Maybe this change would be
> a reasonable thing to do in the stock ixgbevf driver when enabling
> promiscuous mode in the guest?
> 
> Also, it seems to work fine with the DPDK drivers in the guest when the
> host is in promiscuous mode.

If you have a working configuration then that's fine.  I was merely pointing out that promiscuous mode, as the semantics are commonly applied to word in a networking context, is not supported for virtual functions on the 82599 controller.  There are configurations you can apply to suit your own purposes and we would like to support that for you if we can.


----------
Greg Rose
FreeBSD/NFV PAE
Network Division
Intel Corporation
Desk - 503-712-5048

Any man who afflicts the human race with ideas must be prepared to see them misunderstood.
?
- H. L. Mencken


