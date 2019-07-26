From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:47:17 +0000
Subject: [Intel-wired-lan] [next PATCH S8 07/12] i40e: Fix crash caused
 by stress setting of VF MAC addresses
In-Reply-To: <20190723100144.57435-7-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CEB8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 07/12] i40e: Fix crash caused by
> stress setting of VF MAC addresses
> 
> From: Slawomir Laba <slawomirx.laba@intel.com>
> 
> Add update to the vsi pointer passed to the i40e_set_vf_mac function.
> If VF is in reset state the driver waits in i40e_set_vf_mac function for the
> reset to be complete, yet after reset the vsi pointer that was passed into this
> function is no longer valid.
> 
> The patch updates local vsi pointer directly from pf->vsi array, by using the id
> stored in vf pointer (lan_vsi_idx).
> 
> Without this commit the driver might occasionally invoke general protection
> fault in kernel and disable the OS entirely.
> 
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


