From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:03:20 +0000
Subject: [Intel-wired-lan] [PATCH 07/16] ice: Implement virtchnl
 commands for AVF support
In-Reply-To: <20180920002339.11107-8-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC589@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 07/16] ice: Implement virtchnl commands
> for AVF support
> 
> virtchnl is a protocol/interface specification that allows the Intel "Adaptive
> Virtual Function (AVF)" driver (iavf.ko) to work with more than one physical
> function driver. The AVF driver sends "virtchnl commands"
> (control plane only) to the PF driver over mailbox queues and the PF driver
> executes these commands and returns a result to the VF, again over mailbox.
> 
> This patch adds AVF support for the ice PF driver by implementing the
> following virtchnl commands:
> 
> VIRTCHNL_OP_VERSION
> VIRTCHNL_OP_GET_VF_RESOURCES
> VIRTCHNL_OP_RESET_VF
> VIRTCHNL_OP_ADD_ETH_ADDR
> VIRTCHNL_OP_DEL_ETH_ADDR
> VIRTCHNL_OP_CONFIG_VSI_QUEUES
> VIRTCHNL_OP_ENABLE_QUEUES
> VIRTCHNL_OP_DISABLE_QUEUES
> VIRTCHNL_OP_ADD_ETH_ADDR
> VIRTCHNL_OP_DEL_ETH_ADDR
> VIRTCHNL_OP_CONFIG_VSI_QUEUES
> VIRTCHNL_OP_ENABLE_QUEUES
> VIRTCHNL_OP_DISABLE_QUEUES
> VIRTCHNL_OP_REQUEST_QUEUES
> VIRTCHNL_OP_CONFIG_IRQ_MAP
> VIRTCHNL_OP_CONFIG_RSS_KEY
> VIRTCHNL_OP_CONFIG_RSS_LUT
> VIRTCHNL_OP_GET_STATS
> VIRTCHNL_OP_ADD_VLAN
> VIRTCHNL_OP_DEL_VLAN
> VIRTCHNL_OP_ENABLE_VLAN_STRIPPING
> VIRTCHNL_OP_DISABLE_VLAN_STRIPPING
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |    1 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |    1 +
>  drivers/net/ethernet/intel/ice/ice_main.c        |    3 +
>  drivers/net/ethernet/intel/ice/ice_switch.c      |    1 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1204
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   11 +
>  6 files changed, 1221 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


