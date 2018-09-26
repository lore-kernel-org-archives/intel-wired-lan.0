From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:12:44 +0000
Subject: [Intel-wired-lan] [PATCH v2 04/16] ice: Update VSI and queue
 management code to handle VF VSI
In-Reply-To: <20180920004308.13772-5-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC69F@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 04/16] ice: Update VSI and queue
> management code to handle VF VSI
> 
> Until now, all the VSI and queue management code supported only the PF
> VSI type (ICE_VSI_PF). Update these flows to handle the VF VSI type
> (ICE_VSI_VF) type as well.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |   2 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 211 ++++++++++++++++++++-
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |   3 +
>  6 files changed, 184 insertions(+), 35 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


