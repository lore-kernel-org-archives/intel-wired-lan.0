From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:59:13 +0000
Subject: [Intel-wired-lan] [PATCH 11/16] ice: Add code to go from
 ICE_FWD_TO_VSI_LIST to ICE_FWD_TO_VSI
In-Reply-To: <20180920002339.11107-12-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC518@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 11/16] ice: Add code to go from
> ICE_FWD_TO_VSI_LIST to ICE_FWD_TO_VSI
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> When a switch rule is initially created we set the filter action to
> ICE_FWD_TO_VSI. The filter action changes to ICE_FWD_TO_VSI_LIST
> whenever more than one VSI is subscribed to the same switch rule. When
> the switch rule goes from 2 VSIs in the list to 1 VSI we remove and delete the
> VSI list rule, but we currently don't update the switch rule in hardware. This is
> causing switch rules to be lost, so fix that by making a call to
> ice_update_pkt_fwd_rule() with the necessary changes.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 38
> ++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


