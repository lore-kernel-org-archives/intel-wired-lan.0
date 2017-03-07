From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:24:45 +0000
Subject: [Intel-wired-lan] [next PATCH S61 01/10] i40e/i40evf: Update
 code	to better handle incrementing page count
In-Reply-To: <1487721348-25617-2-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401EE6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S61 01/10] i40e/i40evf: Update code
> to better handle incrementing page count
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Update the driver code so that we do bulk updates of the page reference
> count instead of just incrementing it by one reference at a time.  The
> advantage to doing this is that we cut down on atomic operations and this in
> turn should give us a slight improvement in cycles per packet.
> In addition if we eventually move this over to using build_skb the gains will
> be more noticeable.
> 
> I also found and fixed a store forwarding stall from where we were assigning
> "*new_buff = *old_buff".  By breaking it up into individual copies we can
> avoid this and as a result the performance is slightly improved.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I1d3880dece4133eca3c32423b04a5467321ccc52
> ---
> Testing Hints: Make certain this doesn't cause any memory leaks or lead
>         to any data corruptions under heavy Rx traffic with a mix of frame
>         sizes.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 25 ++++++++++++++++++----
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  7 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 24 ++++++++++++++++++--
> ----  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  7 ++++++-
>  4 files changed, 48 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


