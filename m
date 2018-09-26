From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:52:51 +0000
Subject: [Intel-wired-lan] [PATCH 07/16] ice: Move common functions out
 of ice_main.c part 7/7
In-Reply-To: <20180920002319.10971-8-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC477@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 07/16] ice: Move common functions out of
> ice_main.c part 7/7
> 
> This patch completes the code move out of ice_main.c
> 
> The following top level functions and related dependency functions) were
> moved to ice_lib.c:
> ice_vsi_setup
> ice_vsi_cfg_tc
> 
> The following functions were made static again:
> ice_vsi_setup_vector_base
> ice_vsi_alloc_q_vectors
> ice_vsi_get_qs
> void ice_vsi_map_rings_to_vectors
> ice_vsi_alloc_rings
> ice_vsi_set_rss_params
> ice_vsi_set_num_qs
> ice_get_free_slot
> ice_vsi_init
> ice_vsi_alloc_arrays
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 253
> ++++++++++++++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_lib.h  |  26 +--
> drivers/net/ethernet/intel/ice/ice_main.c | 252 -----------------------------
>  3 files changed, 249 insertions(+), 282 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


