From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:08:12 +0000
Subject: [Intel-wired-lan] [next PATCH S15 06/15] i40e/i40evf: Add
 WB_ON_ITR	offload support
In-Reply-To: <1441315142-173025-7-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A63D4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 06/15] i40e/i40evf: Add
> WB_ON_ITR offload support
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 has a way to work around the descriptor WB issue, this offload helps
> turn that feature on.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I7ffa67622426bfca5a651417b63e3afcfeb60412
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h     | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 4 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 5 +++++
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 3 ++-
>  5 files changed, 13 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
