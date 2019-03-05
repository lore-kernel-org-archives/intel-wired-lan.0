From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:30:42 +0000
Subject: [Intel-wired-lan] [PATCH S16 08/11] ice: Add code to get DCB
 related statistics
In-Reply-To: <20190228232432.31659-9-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B60@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S16 08/11] ice: Add code to get DCB related
> statistics
> 
> This patch adds a new function ice_update_dcb_stats to get DCB stats from
> the hardware and ethtool support for displaying these stats.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    | 38
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h    |  2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 36
> +++++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  5 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c       |  2 ++
>  drivers/net/ethernet/intel/ice/ice_type.h       |  5 ++++
>  6 files changed, 86 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


