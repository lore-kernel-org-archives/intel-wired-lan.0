From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 20:44:01 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 07/10] i40e: Detect ATR
	HW	Evict NVM issue and disable the feature
In-Reply-To: <20170623082451.32671-7-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC1B8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S74-V2 07/10] i40e: Detect ATR HW
> Evict NVM issue and disable the feature
> 
> This patch fixes a problem with the HW ATR eviction feature where the NVM
> setting was incorrect.  This patch detects the issue on X720 adapters and
> disables the feature if the NVM setting is incorrect.
> 
> Without this patch, HW ATR Evict feature does not work on broken NVMs
> and is not detected either.  If the HW ATR Evict feature is disabled the SW
> Eviction feature will take effect.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


