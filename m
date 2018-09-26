From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:13:16 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/16] ice: Add handler to
 configure SR-IOV
In-Reply-To: <20180920004308.13772-4-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC6AB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 03/16] ice: Add handler to configure SR-
> IOV
> 
> This patch implements parts of ice_sriov_configure and VF reset flow.
> 
> To create virtual functions (VFs), the user sets a value in num_vfs through
> sysfs. This results in the kernel calling the handler for .sriov_configure which
> is ice_sriov_configure.
> 
> VF setup first starts with a VF reset, followed by allocation of the VF VSI using
> ice_vf_vsi_setup. Once the VF setup is complete a state bit
> ICE_VF_STATE_INIT is set in the vf->states bitmap to indicate that the VF is
> ready to go.
> 
> Also for VF reset to go into effect, it's necessary to issue a disable queue
> command (ice_aqc_opc_dis_txqs). So this patch updates multiple functions
> in the disable queue flow to take additional parameters that distinguish if
> queues are being disabled due to VF reset.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile          |   1 +
>  drivers/net/ethernet/intel/ice/ice.h             |  24 +
>  drivers/net/ethernet/intel/ice/ice_common.c      |  56 +-
>  drivers/net/ethernet/intel/ice/ice_common.h      |   4 +-
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |  38 +
>  drivers/net/ethernet/intel/ice/ice_lib.c         |   7 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h         |   3 +-
>  drivers/net/ethernet/intel/ice/ice_main.c        |   6 +-
>  drivers/net/ethernet/intel/ice/ice_type.h        |  10 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 847
> +++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  74 ++
>  11 files changed, 1061 insertions(+), 9 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


