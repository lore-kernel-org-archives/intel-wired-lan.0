From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:54:22 +0000
Subject: [Intel-wired-lan] [PATCH 06/16] ice: Move common functions out
 of ice_main.c part 6/7
In-Reply-To: <20180920002319.10971-7-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC49E@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 06/16] ice: Move common functions out of
> ice_main.c part 6/7
> 
> This patch continues the code move out of ice_main.c
> 
> The following top level functions (and related dependency functions) were
> moved to ice_lib.c:
> ice_vsi_setup_vector_base
> ice_vsi_alloc_q_vectors
> ice_vsi_get_qs
> 
> The following functions were made static again:
> ice_vsi_free_arrays
> ice_vsi_clear_rings
> 
> Also, in this patch, the netdev and NAPI registration logic was de-coupled
> from the VSI creation logic (ice_vsi_setup) as for SR-IOV, while we want to
> create VF VSIs using ice_vsi_setup, we don't want to create netdevs.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 463
> +++++++++++++++++++++++++++-  drivers/net/ethernet/intel/ice/ice_lib.h
> |  16 +-  drivers/net/ethernet/intel/ice/ice_main.c | 492 +++--------------------
> -------
>  3 files changed, 521 insertions(+), 450 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


