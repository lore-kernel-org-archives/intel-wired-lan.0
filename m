From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:49:20 +0000
Subject: [Intel-wired-lan] [PATCH 01/16] ice: Move common functions out
 of ice_main.c part 1/7
In-Reply-To: <20180920002319.10971-2-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC41C@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 01/16] ice: Move common functions out of
> ice_main.c part 1/7
> 
> The functions that are used for PF VSI/netdev setup will also be used for SR-
> IOV support. To allow reuse of these functions, move these functions out of
> ice_main.c to ice_common.c/ice_lib.c
> 
> This move is done across multiple patches. Each patch moves a few functions
> and may have minor adjustments. For example, a function that was
> previously static in ice_main.c will be made non-static temporarily in its new
> location to allow the driver to build cleanly. These adjustments will be
> removed in subsequent patches where more code is moved out of
> ice_main.c
> 
> In this particular patch, the following functions were moved out of
> ice_main.c:
> int ice_add_mac_to_list
> ice_free_fltr_list
> ice_stat_update40
> ice_stat_update32
> ice_update_eth_stats
> ice_vsi_add_vlan
> ice_vsi_kill_vlan
> ice_vsi_manage_vlan_insertion
> ice_vsi_manage_vlan_stripping
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c |  61 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.h |   4 +
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 258
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h    |  23 ++
>  drivers/net/ethernet/intel/ice/ice_main.c   | 316 +---------------------------
>  6 files changed, 348 insertions(+), 315 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_lib.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


