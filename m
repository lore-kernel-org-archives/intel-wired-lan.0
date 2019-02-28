From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:30:33 +0000
Subject: [Intel-wired-lan] [PATCH S12 01/14] ice: Fix broadcast traffic
 in port VLAN mode
In-Reply-To: <20190208205101.12078-2-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367003@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 01/14] ice: Fix broadcast traffic in port
> VLAN mode
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Set egress (Rx) pruning enable flag for vf vsi in vsi ctxt to enable prune action.
> 
> To avoid seeing broadcast packet in different vlan, pruning enable flag in vsi
> ctxt should be set.
> 
> Write new functions (fill vsi ctx) to not repeat send ctxt code.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 76 ++++++++++++++------
> ----
>  1 file changed, 44 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


