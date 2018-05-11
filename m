From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:16:21 +0000
Subject: [Intel-wired-lan] [next PATCH S91 10/11] i40e: free the skb
 after clearing the bitlock
In-Reply-To: <20180510125949.79823-10-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B76513B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 10, 2018 6:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S91 10/11] i40e: free the skb after
> clearing the bitlock
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In commit bbc4e7d273b5 ("i40e: fix race condition with
> PTP_TX_IN_PROGRESS
> bits") we modified the code which handles Tx timestamps so that we would
> clear the progress bit as soon as possible.
> 
> A later commit 0bc0706b46cd ("i40e: check for Tx timestamp timeouts during
> watchdog") introduced similar code for detecting and handling cleanup of a
> blocked Tx timestamp. This code did not use the same pattern for cleaning
> up the skb.
> 
> Update this code to wait to free the skb until after the bit lock is free, by first
> setting the ptp_tx_skb to NULL and clearing the lock.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

