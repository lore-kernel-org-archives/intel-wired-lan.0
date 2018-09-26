From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:12:07 +0000
Subject: [Intel-wired-lan] [PATCH v2 05/16] ice: Add support for VF
 reset events
In-Reply-To: <20180920004308.13772-6-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC68F@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 05/16] ice: Add support for VF reset
> events
> 
> Post VF initialization, there are a couple of different ways in which a VF reset
> can be triggered. One is when the underlying PF itself goes through a reset
> and other is via a VFLR interrupt. ice_reset_vf introduced in this patch
> handles both these cases.
> 
> Also introduced in this patch is a helper function ice_aq_send_msg_to_vf to
> send messages to VF over the mailbox queue. The PF uses this to send reset
> notifications to VFs.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile          |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h             |   2 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  17 +++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c        |  15 +++
>  drivers/net/ethernet/intel/ice/ice_sriov.c       |  41 ++++++
>  drivers/net/ethernet/intel/ice/ice_sriov.h       |  25 ++++
>  drivers/net/ethernet/intel/ice/ice_status.h      |   3 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 163
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   4 +
>  10 files changed, 272 insertions(+), 1 deletion(-)  create mode 100644


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


