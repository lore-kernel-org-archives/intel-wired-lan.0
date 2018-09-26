From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:49:49 +0000
Subject: [Intel-wired-lan] [PATCH 02/16] ice: Move common functions out
 of ice_main.c part 2/7
In-Reply-To: <20180920002319.10971-3-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC428@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 02/16] ice: Move common functions out of
> ice_main.c part 2/7
> 
> This patch continues the code move out of ice_main.c
> 
> The following top level functions (and related dependency functions) were
> moved to ice_lib.c:
> ice_vsi_start_rx_rings
> ice_vsi_stop_rx_rings
> ice_vsi_stop_tx_rings
> ice_vsi_cfg_rxqs
> ice_vsi_cfg_txqs
> ice_vsi_cfg_msix
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 491
> +++++++++++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_lib.h
> |  13 +  drivers/net/ethernet/intel/ice/ice_main.c | 541 ++-----------------------
> -----
>  3 files changed, 526 insertions(+), 519 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


