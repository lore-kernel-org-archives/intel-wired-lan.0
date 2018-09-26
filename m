From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:52:06 +0000
Subject: [Intel-wired-lan] [PATCH 06/16] ice: Add handlers for VF
 netdevice operations
In-Reply-To: <20180920002339.11107-7-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC466@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 06/16] ice: Add handlers for VF netdevice
> operations
> 
> This patch implements handlers for the following NDO operations:
> 
> .ndo_set_vf_spoofchk
> .ndo_set_vf_mac
> .ndo_get_vf_config
> .ndo_set_vf_trust
> .ndo_set_vf_vlan
> .ndo_set_vf_link_state
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  12 +
>  drivers/net/ethernet/intel/ice/ice_main.c        |   6 +
>  drivers/net/ethernet/intel/ice/ice_sriov.c       |  86 +++++
>  drivers/net/ethernet/intel/ice/ice_sriov.h       |   9 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 438
> +++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  79 +++-
>  6 files changed, 629 insertions(+), 1 deletion(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


