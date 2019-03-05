From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:26:33 +0000
Subject: [Intel-wired-lan] [PATCH S16 01/11] ice: Add code for DCB
 initialization part 1/4
In-Reply-To: <20190228232432.31659-2-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368AF0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 01/11] ice: Add code for DCB
> initialization part 1/4
> 
> This patch introduces a skeleton for ice_init_pf_dcb, the top level function
> for DCB initialization. Subsequent patches will add to this DCB init flow.
> 
> In this patch, ice_init_pf_dcb checks if DCB is a supported capability.
> If so, an admin queue call to start the LLDP and DCBx in firmware is issued. If
> not, an error is reported. Note that we don't fail the driver init if DCB init fails.
> 
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |  1 +
>  drivers/net/ethernet/intel/ice/ice.h            |  3 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 26 ++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb.c        | 85
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb.h        | 37 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    | 42 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h    | 19 ++++++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  3 +
>  drivers/net/ethernet/intel/ice/ice_main.c       | 10 +++
>  drivers/net/ethernet/intel/ice/ice_type.h       |  4 ++
>  10 files changed, 230 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dcb_lib.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


