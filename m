From: Michael Cronenworth <mike@cchtml.com>
Date: Wed, 08 Apr 2015 23:48:51 -0500
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN
 as a part of max frame size
In-Reply-To: <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
References: <alpine.NEB.2.11.1504081019220.3388@chris.i8u.org>
 <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
Message-ID: <552604B3.9070204@cchtml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/08/2015 04:02 PM, Alexander Duyck wrote:
> When the VLAN_HLEN was added to the calculation for the maximum frame size
> there seems to have been a number of issues added to the driver.
>
> The first issue is that in some cases the maximum frame size for a device
> never really reached the actual maximum frame size as the VLAN header
> length was not included the calculation for that value.  As a result some
> parts only supported a maximum frame size of either 1496 in the case of
> parts that didn't support jumbo frames, and 8996 in the case of the parts
> that do.
>
> The second issue is the fact that there were several checks that weren't
> updated so as a result setting an MTU of 1500 was treated as enabling jumbo
> frames as the calculated value was 1522 instead of 1518.  I have addressed
> those by replacing ETH_FRAME_LEN with VLAN_ETH_FRAME_LEN where appropriate.
>
> The final issue was the fact that lowering the MTU below 1500 would cause
> the driver to allocate 2K buffers for the rings.  This is an old issue that
> was fixed several years ago in igb/ixgbe and I am addressing now by just
> replacing == with a <= so that we always just round up to 1522 for anything
> that isn't a jumbo frame.

Alex,

Thanks taking the time to work on a patch.

I have tested this patch in 4.0 on i218-v hardware and it is working. I see 9000 in 
tcpdump (tso/gso off) and my switch blocks packets if I set the max frame size to 
9017 down from 9018.

I also played with a VLAN real quick, and did not encounter any problems, but I 
don't normally use VLANs so it may need further testing.

Thanks,
Michael
