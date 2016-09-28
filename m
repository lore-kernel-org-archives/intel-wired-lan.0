From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Sep 2016 18:50:10 +0000
Subject: [Intel-wired-lan] [next PATCH S48 3/7] i40e: Drop redundant
	Rx	descriptor processing code
In-Reply-To: <1475000934-27335-4-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
 <1475000934-27335-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F011@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 27, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S48 3/7] i40e: Drop redundant Rx
> descriptor processing code
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch cleans up several pieces of redundant code in the Rx clean-up
> paths.
> 
> The first bit is that hdr_addr and the status_err_len portions of the Rx
> descriptor represent the same value.  As such there is no point in setting
> them to 0 before setting them to 0.  I'm dropping the second spot where we
> are updating the value to 0 so that we only have 1 write for this value instead
> of 2.
> 
> The second piece is the checking for the DD bit in the packet.  We only need
> to check for a non-zero value for the status_err_len because if the device is
> done with the descriptor it will have written something back and the DD is
> just one piece of it.  In addition I have moved the reading of the Rx descriptor
> bits related to rx_ptype down so that they are actually below the dma_rmb()
> call so that we are guaranteed that we don't have any funky 64b on 32b calls
> causing any ordering issues.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I256e44a025d3c64a7224aaaec37c852bfcb1871b
> ---
> Testing Hints:
>         We should still receive packets normally.  This change could impact
>         the Rx hashing, but I don't know of any tests for skb->hash.  The
>         only possibility I can think of would be to add a trace point.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 ++++++------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 18 ++++++------------
>  2 files changed, 12 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Packet receive functions work as expected


