From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 20:51:03 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 09/10] i40e/i40evf:
	use	cmpxchg64 when updating private flags in ethtool
In-Reply-To: <20170623082451.32671-9-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC1D9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 09/10] i40e/i40evf: use
> cmpxchg64 when updating private flags in ethtool
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When a user gives an invalid command to change a private flag which is not
> supported, either because it is read-only, or the device is not capable of the
> feature, we simply ignore the request.
> 
> A naive solution would simply be to report error codes when one of the flags
> was not supported. However, this causes problems because it makes the
> operation not atomic. If a user requests multiple private flags together at
> once we could end up changing one before failing at the second flag.
> 
> We can do a bit better if we instead update a temporary copy of the flags
> variable in the loop, and then copy it into place after. If we aren't careful this
> has the pitfall of potentially silently overwriting any changes caused by other
> threads.
> 
> Avoid this by using cmpxchg64 which will compare and swap the flags variable
> only if it currently matched the old value. We'll report -EAGAIN in the
> (hopefully rare!) case where the cmpxchg64 fails.
> 
> This ensures that we can properly report when flags are not supported in an
> atomic fashion without the risk of overwriting other threads changes.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 57 +++++++++++++++---
> ----
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 41 ++++++++++++----
>  2 files changed, 70 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


