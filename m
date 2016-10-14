From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 16:39:33 +0000
Subject: [Intel-wired-lan] [next PATCH S50 3/6] i40e: clear mac filter
 count	on reset
In-Reply-To: <1476224818-16844-4-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA113F1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S50 3/6] i40e: clear mac filter count on
> reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When a VF is reset, it gets a new VSI, so all of its MAC filters go away.
> Correctly set the number of filters to 0 when freeing VF resources. This
> corrects a problem with failure to add filters when the VF driver is reloaded.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I2acbecf734287b67473bb225293e14b5096acbef
> ---
> Testing Hints : Reload the VF driver and observe dmesg on the host.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


