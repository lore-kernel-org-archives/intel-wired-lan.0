From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 16:39:51 +0000
Subject: [Intel-wired-lan] [next PATCH S63 2/6] i40e/i40evf: Pull code
 for	grabbing and syncing rx_buffer from fetch_buffer
In-Reply-To: <1489511727-10959-2-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040683B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, March 14, 2017 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S63 2/6] i40e/i40evf: Pull code for
> grabbing and syncing rx_buffer from fetch_buffer
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch pulls the code responsible for fetching the Rx buffer and
> synchronizing DMA into a function, specifically called i40e_get_rx_buffer.
> 
> The general idea is to allow for better code reuse by pulling this out of
> i40e_fetch_rx_buffer.  We dropped a couple of prefetches since the time
> between the prefetch being called and the data being accessed was too
> small to be useful.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I4885fce4b2637dbedc8e16431169d23d3d7e79b9
> ---
> Testing Hints:
>         Basic Rx testing should be enough to verify this is working
>         correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 58 ++++++++++++++++-------
> ----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 58 ++++++++++++++++------
> -----
>  2 files changed, 68 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


