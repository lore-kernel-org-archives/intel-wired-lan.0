From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:29:47 +0000
Subject: [Intel-wired-lan] [PATCH S16 06/11] ice: Update rings based on
 TC information
In-Reply-To: <20190228232432.31659-7-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B3C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S16 06/11] ice: Update rings based on TC
> information
> 
> This patch adds a new function ice_vsi_cfg_dcb_rings which updates a VSI's
> rings based on DCB traffic class information.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 38
> ++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  8 ++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  2 ++
>  drivers/net/ethernet/intel/ice/ice_main.c    |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  3 +++
>  5 files changed, 52 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


