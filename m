From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Sep 2017 18:47:44 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 13/13] i40e:
	ignore	skb->xmit_more when deciding to set RS bit
In-Reply-To: <20170829093242.41026-13-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-13-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9953@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 13/13] i40e: ignore skb-
> >xmit_more when deciding to set RS bit
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit 6a7fded776a7 ("i40e: Fix RS bit update in Tx path and disable
> force WB workaround") we've tried to "optimize" setting the RS bit based
> around skb->xmit_more. This same logic was refactored in commit
> 1dc8b538795f ("i40e: Reorder logic for coalescing RS bits"), but ultimately was
> not functionally changed.
> 
> Using skb->xmit_more in this way is incorrect, because in certain
> circumstances we may see a large number of skbs in sequence with
> xmit_more set. This leads to a performance loss as the hardware does not
> writeback anything for those packets, which delays the time it takes for us to
> respond to the stack transmit requests. This significantly impacts UDP
> performance, especially when layered with multiple devices, such as
> bonding, vlans, and vnet setups.
> 
> This was not noticed until now because it is difficult to create a setup which
> reproduces the issue. It was discovered in a UDP_STREAM test in a VM,
> connected using a vnet device to a bridge, which is connected to a bonded
> pair of X710 ports in active-backup mode with a VLAN. These layered devices
> seem to compound the number of skbs transmitted at once by the qdisc.
> Additionally, the problem can be masked by reducing the ITR value.
> 
> Since the original commit does not provide strong justification for this RS bit
> "optimization", revert to the previous behavior of setting the RS bit every 4th
> packet.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Testing-hints:
>   This may not be noticeable in many test setups. This was discovered by
>   attaching 2 X710 ports to a bond, adding a vlan device on top of the
>   bond, connecting this to a bridge, and using a vnet device in a VM
>   running netperf UDP_STREAM test.
> 
>   See also RedHat BZ #1384558
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 34 ++++-------------------------
>  1 file changed, 4 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


