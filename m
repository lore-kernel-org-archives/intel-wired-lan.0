From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:07:02 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 3/8] i40e:
	remove	error_param_int label from
	i40e_vc_config_promiscuous_mode_msg
In-Reply-To: <1477436933-13679-4-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA2928D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S51-V2 3/8] i40e: remove
> error_param_int label from i40e_vc_config_promiscuous_mode_msg
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This label is unnecessary, as are jumping to a block that checks aq_ret and
> then immediately skipping it and returning. So just jump straight to the
> error_param and remove this unnecessary label.
> 
> Also use goto error_param even in the last check for style consistency.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If487c7d10c4048e37c594e5eca167693aaed45f6
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


