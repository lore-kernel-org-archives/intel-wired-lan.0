From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 16 Aug 2016 20:36:57 +0000
Subject: [Intel-wired-lan] [next PATCH] i40e: Expose 'trust' flag
	to	userspace via ndo_get_vf_config.
In-Reply-To: <1470329147-25005-1-git-send-email-sridhar.samudrala@intel.com>
References: <1470329147-25005-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8FA9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, August 04, 2016 9:46 AM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> <anjali.singhai@intel.com>
> Subject: [Intel-wired-lan] [next PATCH] i40e: Expose 'trust' flag to userspace
> via ndo_get_vf_config.
> 
> This enables
> 	ip -d l
> to indicate if trust is on or off for VFs.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
