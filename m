From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 17:20:26 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S23 9/13] i40e: Make some
 changes	in the nvm read code
In-Reply-To: <1452297506-1115-1-git-send-email-deepthi.kavalur@intel.com>
References: <1452297506-1115-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9800B6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Friday, January 08, 2016 3:58 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S23 9/13] i40e: Make some changes
> in the nvm read code
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> In X722, NVM reads can't be done through SRCTL registers.
> And require AQ calls, which require grabbing the NVM lock.
> Unfortunately some paths need the lock to be acquired once and do a whole
> bunch of stuff and then release it.
> This patch creates an unsafe version of the read calls, so that it can be called
> from the paths that need the bulk access.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ia9076e9100c5cf61206a856bd279059d3a052024
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 76
> +++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, locks correctly held and released
