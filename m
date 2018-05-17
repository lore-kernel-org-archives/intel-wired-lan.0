From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:10:22 +0000
Subject: [Intel-wired-lan] [next PATCH S92 1/9] i40e: free skb after
 clearing lock in ptp_stop
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771830@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 1/9] i40e: free skb after clearing
> lock in ptp_stop
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Use the same logic to free the skb after clearing the Tx timestamp bit lock in
> i40e_ptp_stop as we use in the other locations. It is not as important here
> since we are not racing against a future Tx timestamp request (as we are
> disabling PTP at this point). However it is good to be consistent in how we
> approach the bit lock so that future callers don't copy the old anti-pattern.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


