From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:27:46 +0000
Subject: [Intel-wired-lan] [PATCH S16 02/11] ice: Add code for DCB
 initialization part 2/4
In-Reply-To: <20190228232432.31659-3-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B00@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S16 02/11] ice: Add code for DCB
> initialization part 2/4
> 
> This patch introduces a new top level function ice_init_dcb (and related
> lower level helper functions) which continues the DCB init flow.
> 
> This function uses ice_get_dcb_cfg to get, parse and store the DCB
> configuration. Once this is done, it sets itself up to be notified by the
> firmware on LLDP MIB change events.
> 
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  79 +++
>  drivers/net/ethernet/intel/ice/ice_dcb.c        | 819
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb.h        |  99 +++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |   2 +-
>  drivers/net/ethernet/intel/ice/ice_status.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |  58 ++
>  6 files changed, 1057 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


